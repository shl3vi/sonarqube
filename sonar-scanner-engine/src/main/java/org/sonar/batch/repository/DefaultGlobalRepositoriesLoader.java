/*
 * SonarQube
 * Copyright (C) 2009-2016 SonarSource SA
 * mailto:contact AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package org.sonar.batch.repository;

import org.sonar.batch.cache.WSLoaderResult;
import org.sonar.scanner.protocol.input.GlobalRepositories;
import org.sonar.batch.cache.WSLoader;

import javax.annotation.Nullable;

import org.apache.commons.lang.mutable.MutableBoolean;

public class DefaultGlobalRepositoriesLoader implements GlobalRepositoriesLoader {

  private static final String BATCH_GLOBAL_URL = "/batch/global";

  private final WSLoader wsLoader;

  public DefaultGlobalRepositoriesLoader(WSLoader wsLoader) {
    this.wsLoader = wsLoader;
  }

  @Override
  public GlobalRepositories load(@Nullable MutableBoolean fromCache) {
    WSLoaderResult<String> result = wsLoader.loadString(BATCH_GLOBAL_URL);
    if (fromCache != null) {
      fromCache.setValue(result.isFromCache());
    }
    return GlobalRepositories.fromJson(result.get());
  }
}
