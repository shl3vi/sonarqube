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

import QualityGateConditions from './QualityGateConditions';
import EmptyQualityGate from './EmptyQualityGate';
import { ComponentType, MeasureType, PeriodsListType } from '../propTypes';
import { translate } from '../../../helpers/l10n';

import './styles.css';

function parseQualityGateDetails (rawDetails) {
  return JSON.parse(rawDetails);
}

function isProject (component) {
  return component.qualifier === 'TRK';
}

const QualityGate = ({ component, status, measure, periods }) => {
  if (!status) {
    return isProject(component) ? <EmptyQualityGate/> : null;
  }

  const level = status.value;

  let conditions = [];
  if (measure) {
    conditions = parseQualityGateDetails(measure.value).conditions;
  }

  return (
      <div className="overview-quality-gate" id="overview-quality-gate">
        <h2 className="overview-title">
          {translate('overview.quality_gate')}
            <span className={'badge badge-' + level.toLowerCase()}>
              {translate('overview.gate', level)}
            </span>
        </h2>

        {conditions.length > 0 && (
            <QualityGateConditions
                component={component}
                periods={periods}
                conditions={conditions}/>
        )}
      </div>
  );
};

QualityGate.propTypes = {
  component: ComponentType.isRequired,
  status: MeasureType,
  measure: MeasureType,
  periods: PeriodsListType.isRequired
};

export default QualityGate;

