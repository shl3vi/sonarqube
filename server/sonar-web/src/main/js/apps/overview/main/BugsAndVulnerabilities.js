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
import React from 'react';
import moment from 'moment';

import { Rating } from './../../../components/shared/rating';
import { IssuesLink } from '../../../components/shared/issues-link';
import { DrilldownLink } from '../../../components/shared/drilldown-link';
import LeakPeriodLegend from '../components/LeakPeriodLegend';
import { getMetricName } from '../helpers/metrics';
import { formatMeasure, isDiffMetric, getPeriodValue } from '../../../helpers/measures';
import { translate, translateWithParameters } from '../../../helpers/l10n';

export default class BugsAndVulnerabilities extends React.Component {
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
    const bugsDomainUrl = window.baseUrl + '/component_measures/domain/Reliability?id=' +
        encodeURIComponent(component.key);
    const vulnerabilitiesDomainUrl = window.baseUrl + '/component_measures/domain/Security?id=' +
        encodeURIComponent(component.key);

    return (
        <div className="overview-card-header">
          <div className="overview-title">
            <a href={bugsDomainUrl}>
              {translate('metric.bugs.name')}
            </a>
            {' & '}
            <a href={vulnerabilitiesDomainUrl}>
              {translate('metric.vulnerabilities.name')}
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

  renderLeak () {
    const { leakPeriod } = this.props;

    if (leakPeriod == null) {
      return null;
    }

    return (
        <div className="overview-domain-leak">
          <LeakPeriodLegend period={leakPeriod}/>

          <div className="overview-domain-measures">
            <div className="overview-domain-measure">
              <div className="overview-domain-measure-value">
                {this.renderIssues('new_bugs', 'BUG')}
              </div>
              <div className="overview-domain-measure-label">
                {getMetricName('new_bugs')}
              </div>
            </div>

            <div className="overview-domain-measure">
              <div className="overview-domain-measure-value">
                {this.renderIssues('new_vulnerabilities', 'VULNERABILITY')}
              </div>
              <div className="overview-domain-measure-label">
                {getMetricName('new_vulnerabilities')}
              </div>
            </div>
          </div>
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
                  {this.renderIssues('bugs', 'BUG')}
                  {this.renderRating('reliability_rating')}
                </div>
                <div className="overview-domain-measure-label">
                  {getMetricName('bugs')}
                </div>
              </div>
            </div>

            <div className="overview-domain-measure">
              <div className="display-inline-block text-middle">
                <div className="overview-domain-measure-value">
                  {this.renderIssues('vulnerabilities', 'VULNERABILITY')}
                  {this.renderRating('security_rating')}
                </div>
                <div className="overview-domain-measure-label">
                  {getMetricName('vulnerabilities')}
                </div>
              </div>
            </div>
          </div>
        </div>
    );
  }

  render () {
    return (
        <div className="overview-card overview-card-special">
          {this.renderHeader()}

          <div className="overview-domain-panel">
            {this.renderNutshell()}
            {this.renderLeak()}
          </div>
        </div>
    );
  }
}
