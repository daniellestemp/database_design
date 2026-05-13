-- ============================================================
-- USER TASKS / QUERIES
-- ============================================================

-- 1. Add a newly-constructed data center and respective utility use 
-- measures to the database. 
-- (NOTE: sample data created with Claude AI, INSERT statements my own)

INSERT INTO data_center (name, county_id) VALUES
	('EdgeCore Austin Campus', 3);

INSERT INTO data_center_measure (data_center_id, measure_type_id,
measure_value, date) VALUES
	(11, 1,  520000.00, '2024-01-01'),   -- Electricity consumption (MWh)
    (11, 8,    2800.00, '2024-01-01'),   -- Cooling water usage (MGal)
    (11, 10,      1.35, '2024-01-01'),   -- PUE ratio
    (11, 9,      55.00, '2024-01-01'),   -- Renewable energy share (%)
    (11, 7,  180000.00, '2024-01-01');   -- Carbon emissions (metric tons CO2e)
    
SELECT * FROM data_center_measure; -- confirm addition

-- 2. Remove an out-of-service data center and respective utility 
-- measures from the database.
    
DELETE FROM data_center_measure
WHERE data_center_id = 9;

DELETE FROM data_center
WHERE data_center_id = 9;

SELECT * FROM data_center; -- confirm deletion

-- 3. Update the water consumption measure for the state of Virginia 
-- for the year 2023.

UPDATE state_measure
SET
	measure_value = 498500.00,
	date = '2023-01-01'
WHERE state_id = 1
	AND measure_type_id = 5;

-- 4. Join tables to view which metropolitan area and state each AI 
-- job is in.

SELECT
    aj.ai_job_id,
    aj.job_title,
    aj.company,
    ma.met_area_name,
    s.state_name
FROM ai_job aj
JOIN met_area_ai_job maaj 
	ON aj.ai_job_id = maaj.ai_job_id
JOIN met_area ma   
	ON maaj.met_area_id = ma.met_area_id
JOIN state s    
	ON ma.state_id = s.state_id
ORDER BY s.state_name, ma.met_area_name, aj.company;

-- 5. View each state's electricity consumption total for 2023.

CREATE VIEW state_electricity_2023 AS
SELECT
	s.state_name,
	mt.measure_name,
	mt.measure_unit,
	SUM(sm.measure_value) AS total_consumption,
	YEAR(sm.date) AS year
FROM state_measure sm
JOIN state s 
	ON sm.state_id = s.state_id
JOIN measure_type mt
	ON sm.measure_type_id = mt.measure_type_id
WHERE sm.measure_type_id = 1
	AND YEAR (sm.date) = 2023
GROUP BY 
	s.state_name,
	mt.measure_name,
	mt.measure_unit,
	YEAR(sm.date)
ORDER BY total_consumption DESC;

-- 6. View the top three states with the highest water consumption, in order
-- from highest to lowest.

SELECT
	s.state_name,
	mt.measure_name,
	mt.measure_unit,
	sm.measure_value AS water_consumption,
	sm.date 
FROM state_measure sm
JOIN state s
	ON sm.state_id = s.state_id 
JOIN measure_type mt
	ON sm.measure_type_id = mt.measure_type_id 
WHERE sm.measure_type_id = 5
ORDER BY sm.measure_value DESC
LIMIT 3;

-- 7. Group metropolitan areas by performance tier.

SELECT
    COALESCE(pt.tier_name, 'ALL TIERS TOTAL') AS performance_tier,
    COALESCE(s.state_name, '---') AS state_name,
    COALESCE(ma.met_area_name, 'Tier Subtotal') AS met_area_name,
    COUNT(ma.met_area_id) AS metro_area_count
FROM met_area_performance_tier mapt
JOIN performance_tier pt 
	ON mapt.tier_id     = pt.tier_id
JOIN met_area ma 
	ON mapt.met_area_id = ma.met_area_id
JOIN state s  
	ON ma.state_id = s.state_id
GROUP BY pt.tier_name, s.state_name, ma.met_area_name
ORDER BY pt.tier_name, s.state_name, ma.met_area_name;

-- 8. Create a transaction inserting a new data center and all of its
-- utility measures in a single operation.
-- (NOTE: sample data below created with Claude AI, INSERT statements my own)

START TRANSACTION;
	INSERT INTO data_center (name, county_id)
	VALUES ('Vantage Phoenix II', 9);
	SET @new_dc_id = LAST_INSERT_ID();
	INSERT INTO data_center_measure (data_center_id, measure_type_id, 
	measure_value, date)
	VALUES
        (@new_dc_id, 1,  430000.00, '2024-06-01'),  -- Electricity consumption (MWh)
        (@new_dc_id, 8,    2400.00, '2024-06-01'),  -- Cooling water usage (MGal)
        (@new_dc_id, 10,      1.40, '2024-06-01'),  -- PUE ratio
        (@new_dc_id, 9,      48.00, '2024-06-01'),  -- Renewable energy share (%)
        (@new_dc_id, 7,  195000.00, '2024-06-01');  -- Carbon emissions (metric tons CO2e);
COMMIT;

-- 9. Create a trigger so that every time a new VC funding record is inserted into 
-- state_vc_activity, it automatically writes a copy to vc_activity_log with a timestamp
-- (essentially creating an audit log to view when records were added and in what order).

-- a. Create the trigger.
CREATE TRIGGER trg_log_vc_activity
AFTER INSERT ON state_vc_activity
FOR EACH ROW
INSERT INTO vc_activity_log (state_vc_activity_id, state_id, vc_amt, date)
VALUES (NEW.state_vc_activity_id, NEW.state_id, NEW.vc_amt, NEW.date);

-- b. Test the trigger.
INSERT INTO state_vc_activity (state_id, vc_amt, date)
VALUES (6, 740.00, '2024-01-01');  -- Illinois, $740M AI VC funding

-- c. Confirm the trigger fired.
SELECT
    val.log_id,
    s.state_name,
    val.vc_amt,
    val.date,
    val.logged_at
FROM vc_activity_log val
JOIN state s ON val.state_id = s.state_id;

-- 10. Calculate the average electricity consumption across data centers 
-- and return the facilities that exceed that average.

SELECT
    dc.data_center_id,
    dc.name AS data_center_name,
    c.name AS county,
    s.state_name,
    dcm.measure_value AS electricity_consumption_mwh,
    dcm.date,
    ROUND(
        (SELECT AVG(measure_value)
         FROM data_center_measure
         WHERE measure_type_id = 1)
    , 2) AS avg_consumption_all_centers
FROM data_center_measure dcm
JOIN data_center dc 
	ON dcm.data_center_id  = dc.data_center_id
JOIN county c 
	ON dc.county_id = c.county_id
JOIN state  s 
	ON c.state_id = s.state_id
WHERE dcm.measure_type_id = 1 
  AND dcm.measure_value > (
        SELECT AVG(measure_value)
        FROM data_center_measure
        WHERE measure_type_id = 1
  )
ORDER BY dcm.measure_value DESC;

-- ================================================================
-- END SCRIPT --
-- ================================================================