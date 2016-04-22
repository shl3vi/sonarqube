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
import moment from 'moment';
import React from 'react';

import { Rating } from './../../../components/shared/rating';
import { IssuesLink } from '../../../components/shared/issues-link';
import { DrilldownLink } from '../../../components/shared/drilldown-link';
import { Timeline } from './timeline';
import { getMetricName } from '../helpers/metrics';
import { translate, translateWithParameters } from '../../../helpers/l10n';
import { formatMeasure, isDiffMetric, getPeriodValue } from '../../../helpers/measures';
import { getPeriodDate } from '../../../helpers/periods';

export default class CodeSmells extends React.Component {
  getValue (measure) {
    if (!measure) {
      return 0;
    }

    return isDiffMetric(measure.metric.key) ?
        getPeriodValue(measure, 1) :
        measure.value;
  }

  renderHeader () {
    const { component } = this.props;
    const domainUrl = window.baseUrl + '/component_measures/domain/Maintainability?id=' +
        encodeURIComponent(component.key);

    return (
        <div className="overview-card-header">
          <div className="overview-title">
            <a href={domainUrl}>
              {translate('metric.code_smells.name')}
            </a>
          </div>
        </div>
    );
  }

  renderRating (metric) {
    const { component, measures } = this.props;
    const measure = measures.find(measure => measure.metric.key === metric);

    if (!measure) {
      return null;
    }

    return (
        <div className="overview-domain-measure-sup">
          <DrilldownLink component={component.key} metric={metric}>
            <Rating value={measure.value}/>
          </DrilldownLink>
        </div>
    );
  }

  renderIssues (metric, type) {
    const { measures, component } = this.props;
    const measure = measures.find(measure => measure.metric.key === metric);
    const value = this.getValue(measure);
    const params = { resolved: 'false', types: type };

    if (isDiffMetric(metric)) {
      Object.assign(params, { sinceLeakPeriod: 'true' });
    }

    const formattedSnapshotDate = moment(component.snapshotDate).format('LLL');
    const tooltip = translateWithParameters('widget.as_calculated_on_x', formattedSnapshotDate);

    return (
        <IssuesLink component={component.key} params={params}>
          <span title={tooltip} data-toggle="tooltip">
            {formatMeasure(value, 'SHORT_INT')}
          </span>
        </IssuesLink>
    );
  }

  renderDebt (metric, type) {
    const { measures, component } = this.props;
    const measure = measures.find(measure => measure.metric.key === metric);
    const value = this.getValue(measure);
    const params = { resolved: 'false', facetMode: 'effort', types: type };

    if (isDiffMetric(metric)) {
      Object.assign(params, { sinceLeakPeriod: 'true' });
    }

    const formattedSnapshotDate = moment(component.snapshotDate).format('LLL');
    const tooltip = translateWithParameters('widget.as_calculated_on_x', formattedSnapshotDate);

    return (
        <IssuesLink component={component.key} params={params}>
          <span title={tooltip} data-toggle="tooltip">
            {formatMeasure(value, 'SHORT_WORK_DUR')}
          </span>
        </IssuesLink>
    );
  }

  renderTimelineStartDate () {
    const momentDate = moment(this.props.historyStartDate);
    const fromNow = momentDate.fromNow();
    return (
        <span className="overview-domain-timeline-date">
          {translateWithParameters('overview.started_x', fromNow)}
        </span>
    );
  }

  renderTimeline (range, displayDate) {
    if (!this.props.history) {
      return null;
    }
    const props = {
      history: this.props.history,
      [range]: getPeriodDate(this.props.leakPeriod)
    };
    return (
        <div className="overview-domain-timeline">
          <Timeline {...props}/>
          {displayDate ? this.renderTimelineStartDate(range) : null}
        </div>
    );
  }

  renderLeak () {
    const { leakPeriod } = this.props;

    if (leakPeriod == null) {
      return null;
    }

    return (
        <div className="overview-domain-leak">
          <div className="overview-domain-measures">
            <div className="overview-domain-measure">
              <div className="overview-domain-measure-value">
                {this.renderIssues('new_code_smells', 'CODE_SMELL')}
              </div>
              <div className="overview-domain-measure-label">
                {getMetricName('new_code_smells')}
              </div>
            </div>

            <div className="overview-domain-measure">
              <div className="overview-domain-measure-value">
                {this.renderDebt('new_effort', 'CODE_SMELL')}
              </div>
              <div className="overview-domain-measure-label">
                {getMetricName('new_effort')}
              </div>
            </div>
          </div>

          {this.renderTimeline('after')}
        </div>
    );
  }

  renderNutshell () {
    return (
        <div className="overview-domain-nutshell">
          <div className="overview-domain-measures">

            <div className="overview-domain-measure">
              <div className="display-inline-block text-middle" style={{ paddingLeft: 56 }}>
                <div className="overview-domain-measure-value">
                  {this.renderIssues('code_smells', 'CODE_SMELL')}
                  {this.renderRating('sqale_rating')}
                </div>
                <div className="overview-domain-measure-label">
                  {getMetricName('code_smells')}
                </div>
              </div>
            </div>

            <div className="overview-domain-measure">
              <div className="display-inline-block text-middle">
                <div className="overview-domain-measure-value">
                  {this.renderDebt('sqale_index', 'CODE_SMELL')}
                </div>
                <div className="overview-domain-measure-label">
                  {getMetricName('effort')}
                </div>
              </div>
            </div>
          </div>

          {this.renderTimeline('before', true)}
        </div>
    );
  }

  render () {
    return (
        <div className="overview-card">
          {this.renderHeader()}

          <div className="overview-domain-panel">
            {this.renderNutshell()}
            {this.renderLeak()}
          </div>
        </div>
    );
  }
}
