-- -------------------------------------------------------------------------------
--
-- Load data into the MIMIC-III schema
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - November 2nd, 2019
--------------------------------------------------------

-- Change to the directory containing the data files

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO mimiciii;

-- Restoring the search path to its default value can be accomplished as follows:
-- SET search_path TO "$user",public;

/* Set the mimic_data_dir variable to point to directory containing
   all .csv files. If using Docker, this should not be changed here.
   Rather, when running the docker container, use the -v option
   to have Docker mount a host volume to the container path /mimic_data
   as explained in the README file
*/

copy ADMISSIONS FROM 'D:\Data Science\MimicDataset\ADMISSIONS.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CHARTEVENTS
--------------------------------------------------------

\copy CHARTEVENTS from 'D:\Data Science\MimicDataset\CHARTEVENTS.csv' delimiter ',' csv header NULL ''

--------------------------------------------------------
--  Load Data for Table CPTEVENTS
--------------------------------------------------------

copy CPTEVENTS from 'D:\Data Science\MimicDataset\CPTEVENTS.csv' delimiter ',' csv header NULL ''


--------------------------------------------------------
--  Load Data for Table DIAGNOSES_ICD
--------------------------------------------------------

copy DIAGNOSES_ICD from 'D:\Data Science\MimicDataset\DIAGNOSES_ICD.csv' delimiter ',' csv header NULL ''

--------------------------------------------------------
--  Load Data for Table D_ICD_DIAGNOSES
--------------------------------------------------------

copy D_ICD_DIAGNOSES from 'D:\Data Science\MimicDataset\D_ICD_DIAGNOSES.csv' delimiter ',' csv header NULL ''

--------------------------------------------------------
--  Load Data for Table D_ICD_PROCEDURES
--------------------------------------------------------

copy D_ICD_PROCEDURES from 'D:\Data Science\MimicDataset\D_ICD_PROCEDURES.csv' delimiter ',' csv header NULL ''


--------------------------------------------------------
--  Load Data for Table ICUSTAYS
--------------------------------------------------------

copy ICUSTAYS from 'D:\Data Science\MimicDataset\ICUSTAYS.csv' delimiter ',' csv header NULL ''


--------------------------------------------------------
--  Load Data for Table PATIENTS
--------------------------------------------------------

copy PATIENTS from 'D:\Data Science\MimicDataset\PATIENTS.csv' delimiter ',' csv header NULL ''


--------------------------------------------------------
--  Load Data for Table PROCEDURES_ICD
--------------------------------------------------------

copy PROCEDURES_ICD from 'D:\Data Science\MimicDataset\PROCEDURES_ICD.csv' delimiter ',' csv header NULL ''

--------------------------------------------------------
--  Load Data for Table SERVICES
--------------------------------------------------------

copy SERVICES from 'D:\Data Science\MimicDataset\SERVICES.csv' delimiter ',' csv header NULL ''