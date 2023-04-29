SELECT CONCAT("# [[", page_title, "]]")
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_id NOT IN
(SELECT page_id
FROM page
WHERE page_id IN (
SELECT cl_from
FROM categorylinks
WHERE cl_to NOT IN (
SELECT page_title
FROM categorylinks, page
WHERE cl_to = 'Categorie_nascoste'
AND page_id = cl_from))
AND page_namespace = 0
AND page_is_redirect = 0)
AND page_id NOT IN 
(SELECT pr_page 
FROM page_restrictions)
ORDER BY page_title;
