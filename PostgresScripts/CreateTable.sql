-- -------------------------------------------------------------------------------
--
-- Create the MIMIC-III tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - November 2nd, 2019
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO mimiciii;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;

/* Set the mimic_data_dir variable to point to directory containing
   all .csv files. If using Docker, this should not be changed here.
   Rather, when running the docker container, use the -v option
   to have Docker mount a host volume to the container path /mimic_data
   as explained in the README file
*/


--------------------------------------------------------
--  DDL for Table ADMISSIONS
--------------------------------------------------------

DROP TABLE IF EXISTS ADMISSIONS CASCADE;
CREATE TABLE ADMISSIONS
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  ADMITTIME TIMESTAMP(0) NOT NULL,
  DISCHTIME TIMESTAMP(0) NOT NULL,
  DEATHTIME TIMESTAMP(0),
  ADMISSION_TYPE VARCHAR(50) NOT NULL,
  ADMISSION_LOCATION VARCHAR(50) NOT NULL,
  DISCHARGE_LOCATION VARCHAR(50) NOT NULL,
  INSURANCE VARCHAR(255) NOT NULL,
  LANGUAGE VARCHAR(10),
  RELIGION VARCHAR(50),
  MARITAL_STATUS VARCHAR(50),
  ETHNICITY VARCHAR(200) NOT NULL,
  EDREGTIME TIMESTAMP(0),
  EDOUTTIME TIMESTAMP(0),
  DIAGNOSIS VARCHAR(255),
  HOSPITAL_EXPIRE_FLAG SMALLINT,
  HAS_CHARTEVENTS_DATA SMALLINT NOT NULL,
  CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID),
  CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID)
) ;


--------------------------------------------------------
--  DDL for Table CPTEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS CPTEVENTS CASCADE;
CREATE TABLE CPTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	COSTCENTER VARCHAR(10) NOT NULL,
	CHARTDATE TIMESTAMP(0),
	CPT_CD VARCHAR(10) NOT NULL,
	CPT_NUMBER INT,
	CPT_SUFFIX VARCHAR(5),
	TICKET_ID_SEQ INT,
	SECTIONHEADER VARCHAR(50),
	SUBSECTIONHEADER VARCHAR(255),
	DESCRIPTION VARCHAR(200),
	CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table CHARTEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS CHARTEVENTS CASCADE;
CREATE TABLE CHARTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT,
	CHARTTIME TIMESTAMP(0),
	STORETIME TIMESTAMP(0),
	CGID INT,
	VALUE VARCHAR(255),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(50),
	WARNING INT,
	ERROR INT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50),
	CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  PARTITION for Table CHARTEVENTS
--------------------------------------------------------

-- CREATE CHARTEVENTS TABLE
 CREATE TABLE chartevents_1 ( CHECK ( itemid >= 0 AND itemid < 127 )) INHERITS (chartevents);
 CREATE TABLE chartevents_2 ( CHECK ( itemid >= 127 AND itemid < 210 )) INHERITS (chartevents);
 CREATE TABLE chartevents_3 ( CHECK ( itemid >= 210 AND itemid < 425 )) INHERITS (chartevents);
 CREATE TABLE chartevents_4 ( CHECK ( itemid >= 425 AND itemid < 549 )) INHERITS (chartevents);
 CREATE TABLE chartevents_5 ( CHECK ( itemid >= 549 AND itemid < 643 )) INHERITS (chartevents);
 CREATE TABLE chartevents_6 ( CHECK ( itemid >= 643 AND itemid < 741 )) INHERITS (chartevents);
 CREATE TABLE chartevents_7 ( CHECK ( itemid >= 741 AND itemid < 1483 )) INHERITS (chartevents);
 CREATE TABLE chartevents_8 ( CHECK ( itemid >= 1483 AND itemid < 3458 )) INHERITS (chartevents);
 CREATE TABLE chartevents_9 ( CHECK ( itemid >= 3458 AND itemid < 3695 )) INHERITS (chartevents);
 CREATE TABLE chartevents_10 ( CHECK ( itemid >= 3695 AND itemid < 8440 )) INHERITS (chartevents);
 CREATE TABLE chartevents_11 ( CHECK ( itemid >= 8440 AND itemid < 8553 )) INHERITS (chartevents);
 CREATE TABLE chartevents_12 ( CHECK ( itemid >= 8553 AND itemid < 220274 )) INHERITS (chartevents);
 CREATE TABLE chartevents_13 ( CHECK ( itemid >= 220274 AND itemid < 223921 )) INHERITS (chartevents);
 CREATE TABLE chartevents_14 ( CHECK ( itemid >= 223921 AND itemid < 224085 )) INHERITS (chartevents);
 CREATE TABLE chartevents_15 ( CHECK ( itemid >= 224085 AND itemid < 224859 )) INHERITS (chartevents);
 CREATE TABLE chartevents_16 ( CHECK ( itemid >= 224859 AND itemid < 227629 )) INHERITS (chartevents);
 CREATE TABLE chartevents_17 ( CHECK ( itemid >= 227629 AND itemid < 999999999 )) INHERITS (chartevents);

-- CREATE CHARTEVENTS TRIGGER
CREATE OR REPLACE FUNCTION chartevents_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
IF ( NEW.itemid >= 0 AND NEW.itemid < 127 ) THEN INSERT INTO chartevents_1 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 127 AND NEW.itemid < 210 ) THEN INSERT INTO chartevents_2 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 210 AND NEW.itemid < 425 ) THEN INSERT INTO chartevents_3 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 425 AND NEW.itemid < 549 ) THEN INSERT INTO chartevents_4 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 549 AND NEW.itemid < 643 ) THEN INSERT INTO chartevents_5 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 643 AND NEW.itemid < 741 ) THEN INSERT INTO chartevents_6 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 741 AND NEW.itemid < 1483 ) THEN INSERT INTO chartevents_7 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 1483 AND NEW.itemid < 3458 ) THEN INSERT INTO chartevents_8 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3458 AND NEW.itemid < 3695 ) THEN INSERT INTO chartevents_9 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3695 AND NEW.itemid < 8440 ) THEN INSERT INTO chartevents_10 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 8440 AND NEW.itemid < 8553 ) THEN INSERT INTO chartevents_11 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 8553 AND NEW.itemid < 220274 ) THEN INSERT INTO chartevents_12 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 220274 AND NEW.itemid < 223921 ) THEN INSERT INTO chartevents_13 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 223921 AND NEW.itemid < 224085 ) THEN INSERT INTO chartevents_14 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 224085 AND NEW.itemid < 224859 ) THEN INSERT INTO chartevents_15 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 224859 AND NEW.itemid < 227629 ) THEN INSERT INTO chartevents_16 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 227629 AND NEW.itemid < 999999999 ) THEN INSERT INTO chartevents_17 VALUES (NEW.*);
ELSE
	INSERT INTO chartevents_null VALUES (NEW.*);
END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_chartevents_trigger
    BEFORE INSERT ON chartevents
    FOR EACH ROW EXECUTE PROCEDURE chartevents_insert_trigger();

--------------------------------------------------------
--  DDL for Table DIAGNOSES_ICD
--------------------------------------------------------

DROP TABLE IF EXISTS DIAGNOSES_ICD CASCADE;
CREATE TABLE DIAGNOSES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT,
	ICD9_CODE VARCHAR(10),
	CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_ICD_DIAGNOSES
--------------------------------------------------------

DROP TABLE IF EXISTS D_ICD_DIAGNOSES CASCADE;
CREATE TABLE D_ICD_DIAGNOSES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID)
) ;



--------------------------------------------------------
--  DDL for Table D_ICD_PROCEDURES
--------------------------------------------------------

DROP TABLE IF EXISTS D_ICD_PROCEDURES CASCADE;
CREATE TABLE D_ICD_PROCEDURES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID)
) ;
--------------------------------------------------------
--  DDL for Table ICUSTAYS
--------------------------------------------------------

DROP TABLE IF EXISTS ICUSTAYS CASCADE;
CREATE TABLE ICUSTAYS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT NOT NULL,
	DBSOURCE VARCHAR(20) NOT NULL,
	FIRST_CAREUNIT VARCHAR(20) NOT NULL,
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP(0) NOT NULL,
	OUTTIME TIMESTAMP(0),
	LOS DOUBLE PRECISION,
	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID),
	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID)
) ;




--------------------------------------------------------
--  DDL for Table PATIENTS
--------------------------------------------------------

DROP TABLE IF EXISTS PATIENTS CASCADE;
CREATE TABLE PATIENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	GENDER VARCHAR(5) NOT NULL,
	DOB TIMESTAMP(0) NOT NULL,
	DOD TIMESTAMP(0),
	DOD_HOSP TIMESTAMP(0),
	DOD_SSN TIMESTAMP(0),
	EXPIRE_FLAG INT NOT NULL,
	CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID),
	CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID)
) ;





--------------------------------------------------------
--  DDL for Table PROCEDURES_ICD
--------------------------------------------------------

DROP TABLE IF EXISTS PROCEDURES_ICD CASCADE;
CREATE TABLE PROCEDURES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table SERVICES
--------------------------------------------------------

DROP TABLE IF EXISTS SERVICES CASCADE;
CREATE TABLE SERVICES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	TRANSFERTIME TIMESTAMP(0) NOT NULL,
	PREV_SERVICE VARCHAR(20),
	CURR_SERVICE VARCHAR(20),
	CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID)
) ;