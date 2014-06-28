CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
FROM page
WHERE page_namespace=0
AND page_is_redirect=0
AND page_id IN (SELECT cl_from
FROM categorylinks
WHERE cl_to LIKE 'Singoli%')
AND page_id IN (SELECT tl_from
FROM templatelinks
WHERE tl_title = 'Canzone')
ORDER BY page_title;
