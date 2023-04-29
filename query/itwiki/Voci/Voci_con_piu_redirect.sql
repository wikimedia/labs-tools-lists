SELECT CONCAT('* [[', rd_title, ']] - ', COUNT(*)) 
 FROM redirect
 JOIN page ON rd_from = page_id
 WHERE page_namespace = 0
 GROUP BY rd_title
 ORDER BY COUNT(*) DESC
 LIMIT 200;