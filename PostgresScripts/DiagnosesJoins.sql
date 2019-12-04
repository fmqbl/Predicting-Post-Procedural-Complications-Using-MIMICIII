select 
a.subject_id,
a.hadm_id,
a.insurance,
a.marital_status,
a.admittime,
a.dischtime,
q.costcenter,
l.first_careunit,
l.last_careunit,
ss.prev_service,
ss.curr_service,
pp.dob,
pp.gender,
gg.icd9_code,
gg.seq_num

from admissions a
inner join 
(
	select c.subject_id,max(c.hadm_id) as hadm_id,c.costcenter from cptevents c
	group by c.costcenter,c.subject_id
) q on q.hadm_id = a.hadm_id
inner join
(
	select ic.subject_id, Max(ic.hadm_id) as hadm_id,ic.first_careunit,ic.last_careunit, ic.icustays_id from icustays ic
	group by ic.subject_id,ic.first_careunit,ic.last_careunit,ic.icustays_id
) l on l.hadm_id = q.hadm_id
inner join services ss on ss.hadm_id = a.hadm_id
inner join patients pp on pp.subject_id = a.subject_id
inner join icd9_diag_proc_full gg on gg.hadm_id = a.hadm_id
--where gg.icd9_code = '996'