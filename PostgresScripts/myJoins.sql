select 
a.subject_id,
a.hadm_id,
a.insurance,
a.ethnicity,
a.marital_status,
a.religion,
a.admittime,
a.dischtime,
q.costcenter,
l.first_careunit,
l.last_careunit,
ss.prev_service,
ss.curr_service,
pp.dob,
pp.gender,
gg.seq_num,
gg.icd9_class

from admissions a
inner join 
(
	select c.subject_id,max(c.hadm_id) as hadm_id,c.costcenter from cptevents c
	group by c.costcenter,c.subject_id
) q on q.hadm_id = a.hadm_id
inner join
(
	select ic.subject_id, Max(ic.hadm_id) as hadm_id,ic.first_careunit,ic.last_careunit from icustays ic
	group by ic.subject_id,ic.first_careunit,ic.last_careunit
) l on l.hadm_id = q.hadm_id
inner join services ss on ss.hadm_id = a.hadm_id
inner join patients pp on pp.subject_id = a.subject_id
inner join diagnoses_seq6 gg on gg.hadm_id = a.hadm_id

where gg.seq_num = 1 -- and gg.icd9_class in ('E87','V58','E93','E88','V10','V45','V49','E91','E94','E84','E00')