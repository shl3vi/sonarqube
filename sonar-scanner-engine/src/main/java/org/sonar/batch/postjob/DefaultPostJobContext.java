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
package org.sonar.batch.postjob;

import org.sonar.batch.issue.tracking.TrackedIssue;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.Iterables;

import javax.annotation.Nullable;

import org.sonar.api.batch.AnalysisMode;
import org.sonar.api.batch.fs.InputComponent;
import org.sonar.api.batch.postjob.PostJobContext;
import org.sonar.api.batch.postjob.issue.Issue;
import org.sonar.api.batch.rule.Severity;
import org.sonar.api.config.Settings;
import org.sonar.api.rule.RuleKey;
import org.sonar.batch.index.BatchComponent;
import org.sonar.batch.index.BatchComponentCache;
import org.sonar.batch.issue.IssueCache;

public class DefaultPostJobContext implements PostJobContext {

  private final Settings settings;
  private final AnalysisMode analysisMode;
  private final IssueCache cache;
  private final BatchComponentCache resourceCache;

  public DefaultPostJobContext(Settings settings, AnalysisMode analysisMode, IssueCache cache, BatchComponentCache resourceCache) {
    this.settings = settings;
    this.analysisMode = analysisMode;
    this.cache = cache;
    this.resourceCache = resourceCache;
  }

  @Override
  public Settings settings() {
    return settings;
  }

  @Override
  public AnalysisMode analysisMode() {
    return analysisMode;
  }

  @Override
  public Iterable<Issue> issues() {
    return Iterables.transform(Iterables.filter(cache.all(), new ResolvedPredicate(false)), new IssueTransformer());
  }

  @Override
  public Iterable<Issue> resolvedIssues() {
    return Iterables.transform(Iterables.filter(cache.all(), new ResolvedPredicate(true)), new IssueTransformer());
  }

  private class DefaultIssueWrapper implements Issue {

    private final TrackedIssue wrapped;

    public DefaultIssueWrapper(TrackedIssue wrapped) {
      this.wrapped = wrapped;
    }

    @Override
    public String key() {
      return wrapped.key();
    }

    @Override
    public RuleKey ruleKey() {
      return wrapped.getRuleKey();
    }

    @Override
    public String componentKey() {
      return wrapped.componentKey();
    }

    @Override
    public InputComponent inputComponent() {
      BatchComponent component = resourceCache.get(wrapped.componentKey());
      return component != null ? component.inputComponent() : null;
    }

    @Override
    public Integer line() {
      return wrapped.startLine();
    }

    @Override
    public Double effortToFix() {
      return wrapped.gap();
    }

    @Override
    public String message() {
      return wrapped.getMessage();
    }

    @Override
    public Severity severity() {
      String severity = wrapped.severity();
      return severity != null ? Severity.valueOf(severity) : null;
    }

    @Override
    public boolean isNew() {
      return wrapped.isNew();
    }
  }

  private class IssueTransformer implements Function<TrackedIssue, Issue> {
    @Override
    public Issue apply(TrackedIssue input) {
      return new DefaultIssueWrapper(input);
    }
  }

  private static class ResolvedPredicate implements Predicate<TrackedIssue> {
    private final boolean resolved;

    private ResolvedPredicate(boolean resolved) {
      this.resolved = resolved;
    }

    @Override
    public boolean apply(@Nullable TrackedIssue issue) {
      if (issue != null) {
        return resolved ? issue.resolution() != null : issue.resolution() == null;
      }
      return false;
    }
  }

}
