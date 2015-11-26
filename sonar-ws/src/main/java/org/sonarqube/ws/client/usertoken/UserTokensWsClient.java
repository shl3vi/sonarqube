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

package org.sonarqube.ws.client.usertoken;

import org.sonarqube.ws.WsComponents.SearchWsResponse;
import org.sonarqube.ws.WsUserTokens.GenerateWsResponse;
import org.sonarqube.ws.client.WsClient;

import static org.sonarqube.ws.client.WsRequest.newGetRequest;
import static org.sonarqube.ws.client.WsRequest.newPostRequest;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.ACTION_GENERATE;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.ACTION_REVOKE;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.ACTION_SEARCH;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.PARAM_LOGIN;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.PARAM_NAME;
import static org.sonarqube.ws.client.usertoken.UserTokensWsParameters.USER_TOKENS_ENDPOINT;

public class UserTokensWsClient {
  private static final String SLASH = "/";
  private final WsClient wsClient;

  public UserTokensWsClient(WsClient wsClient) {
    this.wsClient = wsClient;
  }

  public GenerateWsResponse generate(GenerateWsRequest request) {
    return wsClient.execute(
      newPostRequest(action(ACTION_GENERATE))
        .setParam(PARAM_LOGIN, request.getLogin())
        .setParam(PARAM_NAME, request.getName()),
      GenerateWsResponse.parser());
  }

  public void revoke(RevokeWsRequest request) {
    wsClient.execute(
      newPostRequest(action(ACTION_REVOKE))
        .setParam(PARAM_LOGIN, request.getLogin())
        .setParam(PARAM_NAME, request.getName()));
  }

  public SearchWsResponse search(SearchWsRequest request) {
    return wsClient.execute(
      newGetRequest(action(ACTION_SEARCH))
        .setParam(PARAM_LOGIN, request.getLogin()),
      SearchWsResponse.parser()
    );
  }

  private static String action(String action) {
    return USER_TOKENS_ENDPOINT + SLASH + action;
  }
}
