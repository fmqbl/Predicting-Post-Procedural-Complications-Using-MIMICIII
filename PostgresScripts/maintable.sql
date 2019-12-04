create table maintable as
select * from icd9_diagnoses_full
union
select * from icd9_procedures_full;

delete from maintable
where seq_num > 6