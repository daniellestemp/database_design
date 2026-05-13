-- ============================================================
-- SAMPLE DATA
-- SQL sample data and INSERTS that follow were generated with 
-- the assistance of Anthropic's Claude AI language model.
-- ============================================================

INSERT INTO state (state_name) VALUES
    ('Virginia'),
    ('Texas'),
    ('California'),
    ('Georgia'),
    ('Washington'),
    ('Illinois'),
    ('Ohio'),
    ('Arizona'),
    ('Nevada'),
    ('New York');

INSERT INTO county (state_id, name) VALUES
    (1, 'Loudoun County'),
    (1, 'Prince William County'),
    (2, 'Travis County'),
    (2, 'Harris County'),
    (3, 'Santa Clara County'),
    (3, 'Los Angeles County'),
    (4, 'Fulton County'),
    (5, 'King County'),
    (8, 'Maricopa County'),
    (9, 'Clark County');

INSERT INTO data_center (name, county_id) VALUES
    ('Equinix DC6 - Ashburn',           1),
    ('Amazon AWS US-East-1 Facility',   1),
    ('QTS Richmond Campus',             2),
    ('CyrusOne Austin Campus',          3),
    ('Switch SUPERNAP - Houston',       4),
    ('Google Data Center - Santa Clara',5),
    ('Meta Forest City - Atlanta',      7),
    ('Microsoft Azure - Quincy',        8),
    ('Iron Mountain - Phoenix',         9),
    ('Switch LAS VEGAS 17',            10);

INSERT INTO met_area (state_id, met_area_name) VALUES
    (1, 'Washington-Arlington-Alexandria, DC-VA-MD-WV'),
    (2, 'Austin-Round Rock-Georgetown, TX'),
    (2, 'Houston-The Woodlands-Sugar Land, TX'),
    (3, 'San Jose-Sunnyvale-Santa Clara, CA'),
    (3, 'Los Angeles-Long Beach-Anaheim, CA'),
    (4, 'Atlanta-Sandy Springs-Alpharetta, GA'),
    (5, 'Seattle-Tacoma-Bellevue, WA'),
    (8, 'Phoenix-Mesa-Chandler, AZ'),
    (9, 'Las Vegas-Henderson-Paradise, NV'),
    (10,'New York-Newark-Jersey City, NY-NJ-PA');

INSERT INTO industry (name) VALUES
    ('Technology & Information Services'),
    ('Manufacturing'),
    ('Finance & Insurance'),
    ('Healthcare & Social Assistance'),
    ('Real Estate & Rental'),
    ('Transportation & Warehousing'),
    ('Retail Trade'),
    ('Construction'),
    ('Energy & Utilities'),
    ('Agriculture & Forestry');

INSERT INTO state_industry (state_id, industry_id) VALUES
    (1, 1), (1, 3),
    (2, 2), (2, 9),
    (3, 1), (3, 5),
    (4, 1), (4, 4),
    (5, 1), (5, 6),
    (6, 3), (6, 7),
    (7, 2), (7, 8),
    (8, 9), (8, 5),
    (9, 5), (9, 7),
    (10,3), (10,4);

INSERT INTO performance_tier (tier_name) VALUES
    ('Tier 1 - Elite'),
    ('Tier 2 - Advanced'),
    ('Tier 3 - Emerging'),
    ('Tier 4 - Developing');

INSERT INTO met_area_performance_tier (met_area_id, tier_id) VALUES
    (1,  1),
    (4,  1),
    (10, 1),
    (7,  2),
    (3,  2),
    (6,  2),
    (2,  3),
    (5,  3),
    (8,  3),
    (9,  4);

INSERT INTO ai_job (job_title, company, met_area_id) VALUES
    ('Machine Learning Engineer',       'Amazon',             1),
    ('AI Research Scientist',           'MITRE Corporation',  1),
    ('Data Scientist - NLP',            'Apple',              4),
    ('AI Platform Engineer',            'Google',             4),
    ('MLOps Engineer',                  'Microsoft',          7),
    ('Computer Vision Engineer',        'Meta',               5),
    ('AI Policy Analyst',               'Booz Allen Hamilton',1),
    ('Deep Learning Researcher',        'IBM',               10),
    ('Autonomous Systems Engineer',     'Tesla',              4),
    ('AI Infrastructure Architect',     'Oracle',             8);

INSERT INTO met_area_ai_job (met_area_id, ai_job_id) VALUES
    (1, 1), (1, 2), (1, 7),
    (4, 3), (4, 4), (4, 9),
    (7, 5),
    (5, 6),
    (10,8),
    (8, 10);

INSERT INTO state_vc_activity (state_id, vc_amt, date) VALUES
    (3,  4200.00, '2023-01-01'),
    (3,  5800.50, '2023-07-01'),
    (3,  6100.75, '2024-01-01'),
    (1,   980.00, '2023-01-01'),
    (1,  1240.00, '2024-01-01'),
    (2,  1550.25, '2023-01-01'),
    (2,  1830.00, '2024-01-01'),
    (5,  2100.00, '2023-01-01'),
    (5,  2450.00, '2024-01-01'),
    (10, 3200.00, '2023-01-01'),
    (10, 3750.00, '2024-01-01'),
    (4,   420.00, '2023-01-01'),
    (4,   610.00, '2024-01-01'),
    (6,   890.00, '2023-01-01'),
    (8,   310.00, '2024-01-01');

INSERT INTO measure_type (measure_name, measure_unit, measure_description) VALUES
    ('Electricity Consumption',   'MWh',         'Total electricity consumed in megawatt-hours'),
    ('Electricity Price',         'USD/MWh',      'Average retail price of electricity per megawatt-hour'),
    ('Natural Gas Consumption',   'MMBtu',        'Total natural gas consumed in million British thermal units'),
    ('Natural Gas Price',         'USD/MMBtu',    'Average retail price of natural gas per million BTU'),
    ('Water Consumption',         'MGal',         'Total water consumed in millions of gallons'),
    ('Water Price',               'USD/MGal',     'Average price of water per million gallons'),
    ('Carbon Emissions',          'metric tons CO2e', 'Estimated greenhouse gas emissions in metric tons of CO2 equivalent'),
    ('Cooling Water Usage',       'MGal',         'Water used specifically for cooling systems in data centers'),
    ('Renewable Energy Share',    '%',            'Percentage of total electricity from renewable sources'),
    ('Power Usage Effectiveness', 'ratio',        'PUE ratio: total facility energy / IT equipment energy');

INSERT INTO state_measure (state_id, measure_type_id, measure_value, date) VALUES
    (1, 1, 135000000.00, '2023-01-01'),
    (1, 2,         82.50,'2023-01-01'),
    (1, 3,  28500000.00, '2023-01-01'),
    (1, 5,    450000.00, '2023-01-01'),
    (2, 1, 480000000.00, '2023-01-01'),
    (2, 2,         74.20,'2023-01-01'),
    (2, 3, 120000000.00, '2023-01-01'),
    (2, 5,   1800000.00, '2023-01-01'),
    (3, 1, 280000000.00, '2023-01-01'),
    (3, 2,        196.10,'2023-01-01'),
    (3, 3,  55000000.00, '2023-01-01'),
    (3, 5,   2300000.00, '2023-01-01'),
    (5, 1, 100000000.00, '2023-01-01'),
    (5, 2,         50.30,'2023-01-01'),
    (5, 9,         75.40,'2023-01-01'),
    (10,1, 160000000.00, '2023-01-01'),
    (10,2,        143.80,'2023-01-01'),
    (10,3,  38000000.00, '2023-01-01'),
    (8, 1,  90000000.00, '2023-01-01'),
    (8, 2,         87.60,'2023-01-01'),
    (8, 5,    680000.00, '2023-01-01');

INSERT INTO state_industry_measure (state_industry_id, measure_type_id, measure_value, date) VALUES
    (1, 1,  42000000.00, '2023-01-01'),
    (1, 2,         84.00,'2023-01-01'),
    (1, 7,   5200000.00, '2023-01-01'),
    (2, 1,   8500000.00, '2023-01-01'),
    (3, 1,  95000000.00, '2023-01-01'),
    (3, 3,  48000000.00, '2023-01-01'),
    (4, 3,  72000000.00, '2023-01-01'),
    (5, 1,  68000000.00, '2023-01-01'),
    (5, 9,         62.00,'2023-01-01'),
    (9, 1,  38000000.00, '2023-01-01'),
    (9, 9,         80.50,'2023-01-01');

INSERT INTO industry_measure (industry_id, measure_type_id, measure_value, date) VALUES
    (1, 10,          1.42, '2023-01-01'),
    (1,  9,         55.00, '2023-01-01'),
    (2,  1, 950000000.00,  '2023-01-01'),
    (2,  3, 320000000.00,  '2023-01-01'),
    (3,  1, 120000000.00,  '2023-01-01'),
    (4,  1, 200000000.00,  '2023-01-01'),
    (9,  3, 480000000.00,  '2023-01-01'),
    (6,  5,  95000000.00,  '2023-01-01');

INSERT INTO data_center_measure (data_center_id, measure_type_id, measure_value, date) VALUES
    (1, 1,  850000.00, '2023-01-01'),
    (1, 8,    4500.00, '2023-01-01'),
    (1, 10,      1.38, '2023-01-01'),
    (1, 9,      42.00, '2023-01-01'),
    (2, 1, 2100000.00, '2023-01-01'),
    (2, 8,   12000.00, '2023-01-01'),
    (2, 10,      1.20, '2023-01-01'),
    (2, 9,      85.00, '2023-01-01'),
    (3, 1,  320000.00, '2023-01-01'),
    (3, 8,    1800.00, '2023-01-01'),
    (3, 10,      1.45, '2023-01-01'),
    (4, 1,  410000.00, '2023-01-01'),
    (4, 8,    2200.00, '2023-01-01'),
    (4, 10,      1.50, '2023-01-01'),
    (5, 1,  780000.00, '2023-01-01'),
    (5, 10,      1.30, '2023-01-01'),
    (5, 9,      30.00, '2023-01-01'),
    (6, 1, 1900000.00, '2023-01-01'),
    (6, 8,   10500.00, '2023-01-01'),
    (6, 10,      1.10, '2023-01-01'),
    (6, 9,     100.00, '2023-01-01'),
    (7, 1,  950000.00, '2023-01-01'),
    (7, 8,    5200.00, '2023-01-01'),
    (7, 10,      1.15, '2023-01-01'),
    (7, 9,      70.00, '2023-01-01'),
    (8, 1, 1200000.00, '2023-01-01'),
    (8, 8,    3000.00, '2023-01-01'),
    (8, 10,      1.22, '2023-01-01'),
    (8, 9,      90.00, '2023-01-01'),
    (9, 1,  280000.00, '2023-01-01'),
    (9, 8,    1500.00, '2023-01-01'),
    (9, 10,      1.55, '2023-01-01'),
    (10,1,  660000.00, '2023-01-01'),
    (10,8,    3800.00, '2023-01-01'),
    (10,10,      1.18, '2023-01-01'),
    (10,9,      52.00, '2023-01-01');

-- ============================================================
-- END SCRIPT
-- ============================================================
