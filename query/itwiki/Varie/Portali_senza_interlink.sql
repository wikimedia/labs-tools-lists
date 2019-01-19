USE itwiki_p;
SELECT CONCAT('# [[Portale:', page_title, ']]')
FROM page
WHERE page_namespace=100
AND page_is_redirect = 0
AND page_title NOT LIKE '%/%'
AND page_id NOT IN (SELECT ll_from FROM langlinks)
ORDER BY page_title;
