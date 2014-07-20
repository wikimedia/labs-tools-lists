CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page, pagelinks
WHERE page_is_redirect = 1
AND page_namespace = 0
AND page_id = pl_from
AND page_len > 10*LENGTH(pl_title)+14 
GROUP BY page_title
ORDER BY page_title;