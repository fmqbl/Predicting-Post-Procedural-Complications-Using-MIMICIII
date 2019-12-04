create table icd9_diag_proc_full
as 
Select * from icd9_diagnoses_full
union
select * from icd9_procedures_full