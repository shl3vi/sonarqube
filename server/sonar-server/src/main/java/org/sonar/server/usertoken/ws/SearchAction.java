/*
 * SonarQube, open source software quality management tool.
 * Copyright (C) 2008-2014 SonarSource
 * mailto:contact AT sonarsource DOT com
 *
 * SonarQube is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * SonarQube is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

package org.sonar.server.usertoken.ws;

import java.util.Date;
import java.util.List;
import org.sonar.api.server.ws.Request;
import org.sonar.api.server.ws.Response;
import org.sonar.api.server.ws.WebService;
import org.sonar.core.permission.GlobalPermissions;
import org.sonar.db.DbClient;
import org.sonar.db.DbSession;
import org.sonar.db.user.UserTokenDto;
import org.sonar.server.user.UserSession;
import org.sonarqube.ws.WsUserTokens.SearchWsResponse;
import org.sonarqube.ws.client.usertoken.SearchWsRequest;

import static org.sonar.api.utils.DateUtils.formatDateTime;
import static org.sonar.server.ws.WsUtils.checkFound;
import static org.sonar.server.ws.WsUtils.writeProtobuf;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.ACTION_SEARCH;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.PARAM_LOGIN;

public class SearchAction implements UserTokensWsAction {
  private final DbClient dbClient;
  private final UserSession userSession;

  public SearchAction(DbClient dbClient, UserSession userSession) {
    this.dbClient = dbClient;
    this.userSession = userSession;
  }

  @Override
  public void define(WebService.NewController context) {
    WebService.NewAction action = context.createAction(ACTION_SEARCH)
      .setDescription("List the access tokens of a user. <br />" +
        "The login must exist and active.<br />" +
        "It requires administration permissions.")
      .setResponseExample(getClass().getResource("search-example.json"))
      .setSince("5.3")
      .setHandler(this);

    action.createParam(PARAM_LOGIN)
      .setRequired(true)
      .setDescription("User login")
      .setExampleValue("g.hopper");
  }

  @Override
  public void handle(Request request, Response response) throws Exception {
    SearchWsResponse searchWsResponse = doHandle(toSearchWsRequest(request));
    writeProtobuf(searchWsResponse, request, response);
  }

  private SearchWsResponse doHandle(SearchWsRequest request) {
    userSession.checkLoggedIn().checkGlobalPermission(GlobalPermissions.SYSTEM_ADMIN);

    DbSession dbSession = dbClient.openSession(false);
    try {
      String login = request.getLogin();
      checkLoginExists(dbSession, login);
      List<UserTokenDto> userTokens = dbClient.userTokenDao().selectByLogin(dbSession, login);
      return buildResponse(login, userTokens);
    } finally {
      dbClient.closeSession(dbSession);
    }
  }

  private static SearchWsRequest toSearchWsRequest(Request request) {
    return new SearchWsRequest()
      .setLogin(request.mandatoryParam(PARAM_LOGIN));
  }

  private static SearchWsResponse buildResponse(String login, List<UserTokenDto> userTokensDto) {
    SearchWsResponse.Builder searchWsResponse = SearchWsResponse.newBuilder();
    SearchWsResponse.UserToken.Builder userTokenBuilder = SearchWsResponse.UserToken.newBuilder();
    searchWsResponse.setLogin(login);
    for (UserTokenDto userTokenDto : userTokensDto) {
      userTokenBuilder
        .clear()
        .setName(userTokenDto.getName())
        .setCreatedAt(formatDateTime(new Date(userTokenDto.getCreatedAt())));
      searchWsResponse.addUserTokens(userTokenBuilder);
    }

    return searchWsResponse.build();
  }

  private void checkLoginExists(DbSession dbSession, String login) {
    checkFound(dbClient.userDao().selectByLogin(dbSession, login), "User with login '%s' not found", login);
  }
}
