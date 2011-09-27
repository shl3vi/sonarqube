-- Version 2.11

-- All the rows inserted during Rails migrations. Rows inserted during server startup tasks (Java) are excluded : rules, profiles, metrics, ...
-- Note: do not split a request on multiple lines.
INSERT INTO SONAR.ACTIVE_DASHBOARDS(ID, DASHBOARD_ID, USER_ID, ORDER_INDEX) VALUES (1, 1, null, 1);
ALTER TABLE SONAR.ACTIVE_DASHBOARDS ALTER COLUMN ID RESTART WITH 2;

INSERT INTO SONAR.ACTIVE_FILTERS(ID, FILTER_ID, USER_ID, ORDER_INDEX) VALUES (1, 1, null, 1);
INSERT INTO SONAR.ACTIVE_FILTERS(ID, FILTER_ID, USER_ID, ORDER_INDEX) VALUES (2, 2, null, 2);
INSERT INTO SONAR.ACTIVE_FILTERS(ID, FILTER_ID, USER_ID, ORDER_INDEX) VALUES (3, 3, null, 3);
ALTER TABLE SONAR.ACTIVE_FILTERS ALTER COLUMN ID RESTART WITH 4;

INSERT INTO SONAR.CRITERIA(ID, FILTER_ID, FAMILY, KEE, OPERATOR, VALUE, TEXT_VALUE, VARIATION) VALUES (1, 1, 'qualifier', null, '=', null, 'TRK', null);
INSERT INTO SONAR.CRITERIA(ID, FILTER_ID, FAMILY, KEE, OPERATOR, VALUE, TEXT_VALUE, VARIATION) VALUES (2, 2, 'qualifier', null, '=', null, 'TRK', null);
INSERT INTO SONAR.CRITERIA(ID, FILTER_ID, FAMILY, KEE, OPERATOR, VALUE, TEXT_VALUE, VARIATION) VALUES (3, 3, 'qualifier', null, '=', null, 'VW,SVW,TRK,BRC,DIR,PAC,FIL,CLA,UTS,LIB', null);
ALTER TABLE SONAR.CRITERIA ALTER COLUMN ID RESTART WITH 4;

INSERT INTO SONAR.DASHBOARDS(ID, USER_ID, NAME, DESCRIPTION, COLUMN_LAYOUT, SHARED, CREATED_AT, UPDATED_AT) VALUES (1, null, 'Dashboard', 'Default dashboard', '50%-50%', 1, '2011-09-26 22:27:55.0', '2011-09-26 22:27:55.0');
ALTER TABLE SONAR.DASHBOARDS ALTER COLUMN ID RESTART WITH 2;

INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (1, 1, 'metric', 'alert_status', null, 1, null);
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (2, 1, 'name', null, 'ASC', 2, null);
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (3, 1, 'version', null, null, 3, null);
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (4, 1, 'metric', 'ncloc', null, 4, null);
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (5, 1, 'metric', 'violations_density', null, 5, null);
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (6, 1, 'date', null, null, 6, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (7, 1, 'links', null, null, 7, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (8, 2, 'name', null, 'ASC', 1, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (9, 2, 'metric', 'ncloc', null, 2, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (10, 2, 'metric', 'violations_density', null, 3, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (11, 3, 'metric', 'alert_status', null, 1, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (12, 3, 'name', null, 'ASC', 2, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (13, 3, 'metric', 'ncloc', null, 3, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (14, 3, 'metric', 'violations_density', null, 4, null)
INSERT INTO SONAR.FILTER_COLUMNS(ID, FILTER_ID, FAMILY, KEE, SORT_DIRECTION, ORDER_INDEX, VARIATION) VALUES (15, 3, 'date', null, null, 5, null)
ALTER TABLE SONAR.FILTER_COLUMNS ALTER COLUMN ID RESTART WITH 16;

INSERT INTO SONAR.FILTERS(ID, NAME, USER_ID, SHARED, FAVOURITES, RESOURCE_ID, DEFAULT_VIEW, PAGE_SIZE, PERIOD_INDEX) VALUES (1, 'Projects', null, 1, 0, null, 'list', null, null)
INSERT INTO SONAR.FILTERS(ID, NAME, USER_ID, SHARED, FAVOURITES, RESOURCE_ID, DEFAULT_VIEW, PAGE_SIZE, PERIOD_INDEX) VALUES (2, 'Treemap', null, 1, 0, null, 'treemap', null, null)
INSERT INTO SONAR.FILTERS(ID, NAME, USER_ID, SHARED, FAVOURITES, RESOURCE_ID, DEFAULT_VIEW, PAGE_SIZE, PERIOD_INDEX) VALUES (3, 'My favourites', null, 1, 1, null, 'list', null, null)
ALTER TABLE SONAR.FILTERS ALTER COLUMN ID RESTART WITH 4;

INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (1, 1, null, 'admin')
INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (2, 1, null, 'default-admin')
INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (3, 2, null, 'default-user')
INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (4, null, null, 'default-user')
INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (5, 2, null, 'default-codeviewer')
INSERT INTO SONAR.GROUP_ROLES(ID, GROUP_ID, RESOURCE_ID, ROLE) VALUES (6, null, null, 'default-codeviewer')
ALTER TABLE SONAR.GROUP_ROLES ALTER COLUMN ID RESTART WITH 7;

INSERT INTO SONAR.GROUPS(ID, NAME, DESCRIPTION, CREATED_AT, UPDATED_AT) VALUES (1, 'sonar-administrators', 'System administrators', '2011-09-26 22:27:51.0', '2011-09-26 22:27:51.0')
INSERT INTO SONAR.GROUPS(ID, NAME, DESCRIPTION, CREATED_AT, UPDATED_AT) VALUES (2, 'sonar-users', 'Any new users created will automatically join this group', '2011-09-26 22:27:51.0', '2011-09-26 22:27:51.0')
ALTER TABLE SONAR.GROUPS ALTER COLUMN ID RESTART WITH 3;

INSERT INTO SONAR.GROUPS_USERS(USER_ID, GROUP_ID) VALUES (1, 1)
INSERT INTO SONAR.GROUPS_USERS(USER_ID, GROUP_ID) VALUES (1, 2)

INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('1')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('2')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('10')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('11')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('13')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('14')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('16')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('35')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('36')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('39')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('41')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('46')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('48')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('49')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('51')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('52')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('53')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('54')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('55')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('57')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('58')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('59')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('60')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('61')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('62')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('66')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('68')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('69')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('72')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('73')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('75')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('76')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('77')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('78')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('79')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('80')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('81')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('82')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('84')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('85')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('86')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('87')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('88')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('89')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('90')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('91')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('92')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('93')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('94')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('95')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('96')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('97')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('98')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('99')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('100')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('101')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('110')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('111')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('112')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('113')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('114')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('115')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('116')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('117')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('118')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('119')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('120')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('131')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('132')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('133')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('134')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('135')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('136')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('137')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('138')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('139')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('140')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('141')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('142')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('150')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('151')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('160')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('162')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('163')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('165')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('166')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('167')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('168')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('169')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('170')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('180')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('181')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('190')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('191')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('200')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('201')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('202')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('203')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('210')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('211')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('212')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('213')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('214')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('215')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('216')
INSERT INTO SONAR.SCHEMA_MIGRATIONS(VERSION) VALUES ('217')

INSERT INTO SONAR.USERS(ID, LOGIN, NAME, EMAIL, CRYPTED_PASSWORD, SALT, CREATED_AT, UPDATED_AT, REMEMBER_TOKEN, REMEMBER_TOKEN_EXPIRES_AT) VALUES (1, 'admin', 'Administrator', '', 'a373a0e667abb2604c1fd571eb4ad47fe8cc0878', '48bc4b0d93179b5103fd3885ea9119498e9d161b', '2011-09-26 22:27:48.0', '2011-09-26 22:27:48.0', null, null)
ALTER TABLE SONAR.USERS ALTER COLUMN ID RESTART WITH 2;

INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (1, 1, 'size', 'Size metrics', null, 1, 1, 1, '2011-09-26 22:27:55.0', '2011-09-26 22:27:55.0')
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (2, 1, 'comments_duplications', 'Comments duplications', null, 1, 2, 1, '2011-09-26 22:27:55.0', '2011-09-26 22:27:55.0')
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (3, 1, 'complexity', 'Complexity', null, 1, 3, 1, '2011-09-26 22:27:55.0', '2011-09-26 22:27:55.0')
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (4, 1, 'code_coverage', 'Code coverage', null, 1, 4, 1, '2011-09-26 22:27:55.0', '2011-09-26 22:27:55.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (5, 1, 'events', 'Events', null, 1, 5, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (6, 1, 'description', 'Description', null, 1, 6, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (7, 1, 'rules', 'Rules', null, 2, 1, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (8, 1, 'alerts', 'Alerts', null, 2, 2, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (9, 1, 'file_design', 'File design', null, 2, 3, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (10, 1, 'package_design', 'Package design', null, 2, 4, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
INSERT INTO SONAR.WIDGETS(ID, DASHBOARD_ID, WIDGET_KEY, NAME, DESCRIPTION, COLUMN_INDEX, ROW_INDEX, CONFIGURED, CREATED_AT, UPDATED_AT) VALUES (11, 1, 'ckjm', 'CKJM', null, 2, 5, 1, '2011-09-26 22:27:56.0', '2011-09-26 22:27:56.0');
ALTER TABLE SONAR.WIDGETS ALTER COLUMN ID RESTART WITH 12;
