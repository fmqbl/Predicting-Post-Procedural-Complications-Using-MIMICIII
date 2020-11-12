-- To composite the final data frame, following sql (postgresql) code is used. comment added to track the changes and validate on the new system
select 
a.subject_id,
a.hadm_id,
l.icustay_id,
a.insurance,
a.marital_status,
a.hospital_expire_flag,
l.los,
pp.gender,
gg.icd9_code,
gg.seq_num

into finaldf

from admissions a
inner join 
(
	select c.subject_id,max(c.hadm_id) as hadm_id,c.costcenter from cptevents c
	group by c.costcenter,c.subject_id
) q on q.hadm_id = a.hadm_id
inner join
(
	select ic.subject_id, Max(ic.hadm_id) as hadm_id,ic.first_careunit,ic.last_careunit, ic.icustay_id,ic.los from icustays ic
	group by ic.subject_id,ic.first_careunit,ic.last_careunit,ic.icustay_id,ic.los
) l on l.hadm_id = q.hadm_id
inner join services ss on ss.hadm_id = a.hadm_id
inner join patients pp on pp.subject_id = a.subject_id
inner join maintable gg on gg.hadm_id = a.hadm_id