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

import enhance from './enhance';
import { DrilldownLink } from '../../../components/shared/drilldown-link';
import { getMetricName } from '../helpers/metrics';
import { formatMeasure, getPeriodValue } from '../../../helpers/measures';
import { translate } from '../../../helpers/l10n';

class Coverage extends React.Component {
  getCoverageMetricPrefix () {
    const { measures } = this.props;
    const hasOverallCoverage = !!measures
        .find(measure => measure.metric.key === 'overall_coverage');
    const hasUTCoverage = !!measures
        .find(measure => measure.metric.key === 'coverage');
    const hasITCoverage = !!measures
        .find(measure => measure.metric.key === 'it_coverage');

    if (hasOverallCoverage && hasUTCoverage && hasITCoverage) {
      return 'overall_';
    } else if (hasITCoverage) {
      return 'it_';
    } else {
      return '';
    }
  }

  getCoverage (prefix) {
    const { measures } = this.props;
    const { value } = measures
        .find(measure => measure.metric.key === `${prefix}coverage`);
    return Number(value);
  }

  getNewCoverageMeasure (prefix) {
    const { measures } = this.props;
    return measures
        .find(measure => measure.metric.key === `new_${prefix}coverage`);
  }

  renderHeader () {
    return this.props.renderHeader(
        'Coverage',
        translate('metric.coverage.name'));
  }

  renderTimeline (coverageMetricPrefix, range) {
    const metricKey = `${coverageMetricPrefix}coverage`;
    return this.props.renderTimeline(metricKey, range);
  }

  renderTests () {
    return this.props.renderMeasure('tests');
  }

  renderCoverageDonut (coverage) {
    const data = [
      { value: coverage, fill: '#85bb43' },
      { value: 100 - coverage, fill: '#d4333f' }
    ];
    return this.props.renderDonut(data);
  }

  renderCoverage (coverageMetricPrefix) {
    const { component } = this.props;
    const metric = `${coverageMetricPrefix}coverage`;
    const coverage = this.getCoverage(coverageMetricPrefix);

    return (
        <div className="overview-domain-measure">
          {this.renderCoverageDonut(coverage)}

          <div className="display-inline-block text-middle">
            <div className="overview-domain-measure-value">
              <DrilldownLink component={component.key} metric={metric}>
                <span className="js-overview-main-coverage">
                  {formatMeasure(coverage, 'PERCENT')}
                </span>
              </DrilldownLink>
            </div>

            <div className="overview-domain-measure-label">
              {getMetricName('coverage')}
            </div>
          </div>
        </div>
    );
  }

  renderNewCoverage (coverageMetricPrefix) {
    const { component, leakPeriod } = this.props;
    const newCoverageMeasure = this.getNewCoverageMeasure(coverageMetricPrefix);

    const value = newCoverageMeasure ? (
        <DrilldownLink
            component={component.key}
            metric={newCoverageMeasure.metric.key}
            period={leakPeriod.index}>
          <span className="js-overview-main-new-coverage">
            {formatMeasure(getPeriodValue(newCoverageMeasure, leakPeriod.index), 'PERCENT')}
          </span>
        </DrilldownLink>
    ) : (
        <span>—</span>
    );

    return (
        <div className="overview-domain-measure">
          <div className="overview-domain-measure-value">
            {value}
          </div>

          <div className="overview-domain-measure-label">
            {getMetricName('new_coverage')}
          </div>
        </div>
    );
  }

  renderNutshell (coverageMetricPrefix) {
    return (
        <div className="overview-domain-nutshell">
          <div className="overview-domain-measures">
            {this.renderCoverage(coverageMetricPrefix)}
            {this.renderTests()}
          </div>

          {this.renderTimeline(coverageMetricPrefix, 'before')}
        </div>
    );
  }

  renderLeak (coverageMetricPrefix) {
    const { leakPeriod } = this.props;

    if (leakPeriod == null) {
      return null;
    }

    return (
        <div className="overview-domain-leak">
          <div className="overview-domain-measures">
            {this.renderNewCoverage(coverageMetricPrefix)}
          </div>

          {this.renderTimeline(coverageMetricPrefix, 'after')}
        </div>
    );
  }

  render () {
    const { measures } = this.props;
    const coverageMetricPrefix = this.getCoverageMetricPrefix();
    const coverageMeasure =
        measures.find(measure => measure.metric.key === `${coverageMetricPrefix}coverage`);

    if (coverageMeasure == null) {
      return null;
    }

    return (
        <div className="overview-card">
          {this.renderHeader()}

          <div className="overview-domain-panel">
            {this.renderNutshell(coverageMetricPrefix)}
            {this.renderLeak(coverageMetricPrefix)}
          </div>
        </div>
    );
  }
}

export default enhance(Coverage);
