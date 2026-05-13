-- ================================================================
-- SCHEMA
-- ================================================================

CREATE DATABASE us_ai_industry
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

USE us_ai_industry;

--DROP DATABASE us_ai_industry;

-- ================================================================
-- 1. CREATE LOCATION ENTITIES
-- ================================================================

CREATE TABLE state (
    state_id    INT AUTO_INCREMENT PRIMARY KEY,
    state_name  VARCHAR(50) NOT NULL
);

CREATE TABLE county (
    county_id   INT AUTO_INCREMENT PRIMARY KEY,
    state_id    INT NOT NULL,
    name        VARCHAR(100) NOT NULL,
    CONSTRAINT fk_county_state FOREIGN KEY (state_id) REFERENCES state(state_id)
);

CREATE TABLE data_center (
    data_center_id  INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    county_id       INT NOT NULL,
    CONSTRAINT fk_datacenter_county FOREIGN KEY (county_id) REFERENCES county(county_id)
);

CREATE TABLE met_area (
    met_area_id     INT AUTO_INCREMENT PRIMARY KEY,
    state_id        INT NOT NULL,
    met_area_name   VARCHAR(150) NOT NULL,
    CONSTRAINT fk_metarea_state FOREIGN KEY (state_id) REFERENCES state(state_id)
);

-- ================================================================
-- 2. CREATE INDUSTRY ENTITIES
-- ================================================================

CREATE TABLE industry (
    industry_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL
);

CREATE TABLE state_industry (
    state_industry_id   INT AUTO_INCREMENT PRIMARY KEY,
    state_id            INT NOT NULL,
    industry_id         INT NOT NULL,
    CONSTRAINT fk_si_state    FOREIGN KEY (state_id)    REFERENCES state(state_id),
    CONSTRAINT fk_si_industry FOREIGN KEY (industry_id) REFERENCES industry(industry_id)
);

-- ================================================================
-- 3. AI ACTIVITY ENTITIES
-- ================================================================

CREATE TABLE state_vc_activity (
    state_vc_activity_id    INT AUTO_INCREMENT PRIMARY KEY,
    state_id                INT NOT NULL,
    vc_amt                  DECIMAL(15, 2) NOT NULL,
    date                    DATE NOT NULL,
    CONSTRAINT fk_vc_state FOREIGN KEY (state_id) REFERENCES state(state_id)
);

CREATE TABLE ai_job (
    ai_job_id   INT AUTO_INCREMENT PRIMARY KEY,
    job_title   VARCHAR(150) NOT NULL,
    company     VARCHAR(150) NOT NULL,
    met_area_id INT NOT NULL,
    CONSTRAINT fk_aijob_metarea FOREIGN KEY (met_area_id) REFERENCES met_area(met_area_id)
);

CREATE TABLE met_area_ai_job (
    met_area_ai_job_id  INT AUTO_INCREMENT PRIMARY KEY,
    met_area_id         INT NOT NULL,
    ai_job_id           INT NOT NULL,
    CONSTRAINT fk_maaj_metarea FOREIGN KEY (met_area_id) REFERENCES met_area(met_area_id),
    CONSTRAINT fk_maaj_aijob   FOREIGN KEY (ai_job_id)   REFERENCES ai_job(ai_job_id)
);

-- ================================================================
-- 4. AI PERFORMANCE ENTITIES
-- ================================================================

CREATE TABLE performance_tier (
    tier_id     INT AUTO_INCREMENT PRIMARY KEY,
    tier_name   VARCHAR(50) NOT NULL
);

CREATE TABLE met_area_performance_tier (
    met_performance_tier_id INT AUTO_INCREMENT PRIMARY KEY,
    met_area_id             INT NOT NULL,
    tier_id                 INT NOT NULL,
    CONSTRAINT fk_mapt_metarea FOREIGN KEY (met_area_id) REFERENCES met_area(met_area_id),
    CONSTRAINT fk_mapt_tier    FOREIGN KEY (tier_id)     REFERENCES performance_tier(tier_id)
);

CREATE TABLE vc_activity_log (
    log_id               INT AUTO_INCREMENT PRIMARY KEY,
    state_vc_activity_id INT            NOT NULL,
    state_id             INT            NOT NULL,
    vc_amt               DECIMAL(15, 2) NOT NULL,
    date                 DATE           NOT NULL,
    logged_at            DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ================================================================
-- 5. UTILITY MEASURE ENTITIES
-- ================================================================

CREATE TABLE measure_type (
    measure_type_id     INT AUTO_INCREMENT PRIMARY KEY,
    measure_name        VARCHAR(100) NOT NULL,
    measure_unit        VARCHAR(50)  NOT NULL,
    measure_description TEXT
);

CREATE TABLE industry_measure (
    industry_measure_id INT AUTO_INCREMENT PRIMARY KEY,
    industry_id         INT NOT NULL,
    measure_type_id     INT NOT NULL,
    measure_value       DECIMAL(18, 4) NOT NULL,
    date                DATE NOT NULL,
    CONSTRAINT fk_im_industry    FOREIGN KEY (industry_id)     REFERENCES industry(industry_id),
    CONSTRAINT fk_im_measuretype FOREIGN KEY (measure_type_id) REFERENCES measure_type(measure_type_id)
);

CREATE TABLE state_industry_measure (
    state_industry_measure_id  INT AUTO_INCREMENT PRIMARY KEY,
    state_industry_id          INT NOT NULL,
    measure_type_id            INT NOT NULL,
    measure_value              DECIMAL(18, 4) NOT NULL,
    date                       DATE NOT NULL,
    CONSTRAINT fk_sim_stateindustry FOREIGN KEY (state_industry_id) REFERENCES state_industry(state_industry_id),
    CONSTRAINT fk_sim_measuretype   FOREIGN KEY (measure_type_id)   REFERENCES measure_type(measure_type_id)
);

CREATE TABLE state_measure (
    state_measure_id    INT AUTO_INCREMENT PRIMARY KEY,
    state_id            INT NOT NULL,
    measure_type_id     INT NOT NULL,
    measure_value       DECIMAL(18, 4) NOT NULL,
    date                DATE NOT NULL,
    CONSTRAINT fk_sm_state       FOREIGN KEY (state_id)        REFERENCES state(state_id),
    CONSTRAINT fk_sm_measuretype FOREIGN KEY (measure_type_id) REFERENCES measure_type(measure_type_id)
);

CREATE TABLE data_center_measure (
    data_center_measure_id  INT AUTO_INCREMENT PRIMARY KEY,
    data_center_id          INT NOT NULL,
    measure_type_id         INT NOT NULL,
    measure_value           DECIMAL(18, 4) NOT NULL,
    date                    DATE NOT NULL,
    CONSTRAINT fk_dcm_datacenter  FOREIGN KEY (data_center_id)  REFERENCES data_center(data_center_id),
    CONSTRAINT fk_dcm_measuretype FOREIGN KEY (measure_type_id) REFERENCES measure_type(measure_type_id)
);