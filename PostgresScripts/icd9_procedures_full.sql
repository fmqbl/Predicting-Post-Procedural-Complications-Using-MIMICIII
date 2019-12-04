with cte as
(select icd9_code, count(icd9_code) as total_count from 
(select row_id,substring(icd9_code,1,3) as icd9_code, short_title from d_icd_procedures) sq
group by icd9_code
having count(icd9_code) > 5
order by icd9_code desc)

select c.row_id,c.subject_id,c.hadm_id,c.seq_num, cte.icd9_code as icd9_code, a.short_title into icd9_procedures_full
from cte 
join d_icd_procedures a on substring(a.icd9_code,1,3) = cte.icd9_code
join procedures_icd c on a.icd9_code = c.icd9_code