CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[Template:", page_title, "]]")
FROM page
WHERE page_namespace = 10
AND page_title NOT LIKE '%/%'
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
AND page_namespace = 10
AND page_is_redirect = 0)
ORDER BY page_title;
