WITH CTE AS
(SELECT *, DENSE_RANK() OVER (ORDER BY subject_id,hadm_id,icd9_code,seq_num,icustay_id) as R
FROM finaldf)

--select * from cte
SELECT MAX(ID) as id ,subject_id,hadm_id,seq_num,icd9_code,icustay_id into idLookupTable
FROM CTE
--where icd9_code = '996'
GROUP BY r,subject_id,hadm_id,seq_num,icd9_code,icustay_id
order by subject_id