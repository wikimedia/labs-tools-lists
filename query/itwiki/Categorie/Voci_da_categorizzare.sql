CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
FROM page
WHERE page_id NOT IN (
SELECT cl_from
FROM categorylinks
WHERE cl_from NOT IN (
SELECT cl_from
FROM categorylinks
WHERE cl_to = 'Categorie_nascoste'))
AND page_namespace = 0
AND page_is_redirect = 0
ORDER BY page_title;
