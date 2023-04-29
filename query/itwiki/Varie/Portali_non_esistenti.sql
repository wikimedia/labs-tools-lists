SELECT CONCAT("# [[", page_title, "]] -> [[Portale:", pl_title, "]]")
FROM pagelinks, page
WHERE pl_from = page_id
AND pl_namespace = 100
AND pl_from_namespace = 0
AND pl_title NOT IN (
SELECT page_title
FROM page
WHERE page_namespace = 100)
AND pl_title NOT LIKE 'Televisione/Elenco%'
ORDER BY pl_title, page_title;
