CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
LEFT JOIN revision ON page_id = rev_page
WHERE page_namespace = 0
AND rev_parent_id = 0
AND (rev_user = 0
OR rev_user IN
(SELECT user_id FROM user WHERE user_editcount < 50))
AND page_id IN
(SELECT tl_from FROM templatelinks
LEFT JOIN page ON tl_from = page_id
WHERE tl_title LIKE 'W')
ORDER BY page_title;
