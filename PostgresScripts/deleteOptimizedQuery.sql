DELETE FROM finaldf 
WHERE id IN (select f.id from finaldf f 
          LEFT JOIN idlookuptable d on f.id = d.id
              WHERE d.id IS NULL)