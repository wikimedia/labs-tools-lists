SET @counter = 0;
SELECT @counter := @counter +1, pages_created, rev_user_text
FROM (SELECT COUNT(*) as pages_created, rev_user_text
FROM page, revision
WHERE page_namespace = 108
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
GROUP BY rev_user_text) sub
ORDER BY pages_created DESC
LIMIT 1000