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

import QualityGate from '../qualityGate/QualityGate';
import GeneralMain from './../main/main';
import Meta from './Meta';
import { getMetrics } from '../../../api/metrics';
import { getMeasuresAndMeta } from '../../../api/measures';
import { enhanceMeasuresWithMetrics } from '../../../helpers/measures';
import { getLeakPeriod } from '../../../helpers/periods';

const METRICS = [
  // quality gate
  'alert_status',
  'quality_gate_details',

  // bugs
  'bugs',
  'new_bugs',
  'reliability_rating',

  // vulnerabilities
  'vulnerabilities',
  'new_vulnerabilities',
  'security_rating',

  // code smells
  'code_smells',
  'new_code_smells',
  'sqale_rating',
  'sqale_index',
  'new_technical_debt',

  // coverage
  'overall_coverage',
  'new_overall_coverage',
  'coverage',
  'new_coverage',
  'it_coverage',
  'new_it_coverage',
  'tests',

  // duplications
  'duplicated_lines_density',
  'duplicated_blocks',

  // size
  'ncloc',
  'ncloc_language_distribution'
];

export default class OverviewApp extends React.Component {
  state = {
    loading: true
  };

  componentDidMount () {
    this.mounted = true;
    document.querySelector('html').classList.add('dashboard-page');
    this.requestMetrics();
    this.loadMeasures(this.props.component);
  }

  componentDidUpdate (nextProps) {
    if (this.props.component !== nextProps.component) {
      this.loadMeasures(nextProps.component);
    }
  }

  componentWillUnmount () {
    this.mounted = false;
    document.querySelector('html').classList.remove('dashboard-page');
  }

  requestMetrics () {
    return getMetrics().then(metrics => {
      if (this.mounted) {
        this.setState({ metrics });
      }
    });
  }

  loadMeasures (component) {
    this.setState({ loading: true });

    getMeasuresAndMeta(
        component.key,
        METRICS,
        { additionalFields: 'metrics,periods' }
    ).then(r => {
      if (this.mounted) {
        this.setState({
          loading: false,
          measures: enhanceMeasuresWithMetrics(r.component.measures, r.metrics),
          periods: r.periods
        });
      }
    });
  }

  renderLoading () {
    return (
        <div className="text-center">
          <i className="spinner spinner-margin"/>
        </div>
    );
  }

  render () {
    const { loading, metrics, measures, periods } = this.state;

    if (!metrics || loading) {
      return this.renderLoading();
    }

    const props = { ...this.props, metrics: this.state.metrics };

    const leakPeriod = getLeakPeriod(periods);

    const qualityGateStatusMeasure =
        measures.find(measure => measure.metric.key === 'alert_status');
    const qualityGateMeasure =
        measures.find(measure => measure.metric.key === 'quality_gate_details');

    return (
        <div className="page page-limited">
          <div className="overview">
            <div className="overview-main">
              <QualityGate
                  component={this.props.component}
                  status={qualityGateStatusMeasure}
                  measure={qualityGateMeasure}
                  periods={periods}/>

              <GeneralMain {...props} measures={measures} leakPeriod={leakPeriod}/>
            </div>
            <Meta component={props.component}/>
          </div>
        </div>
    );
  }
}
