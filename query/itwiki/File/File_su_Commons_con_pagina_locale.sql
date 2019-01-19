USE itwiki_p;
SELECT CONCAT('# [[:File:', page_title, ']]')
FROM page
WHERE page_namespace = 6
AND page_is_redirect = 0
AND page_title NOT IN
(SELECT img_name
FROM image)
ORDER BY page_title;
