CONNECT itwiki_p itwiki.labsdb;
SET @counter = 0;
SELECT @counter := @counter +1, pages_created, rev_user_text
FROM (SELECT COUNT(*) as pages_created, rev_user_text
FROM page, revision, user_groups
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
AND rev_user = ug_user
AND ug_group NOT LIKE "bot"
AND ug_group NOT LIKE "ipblock%"
GROUP BY rev_user_text) sub
ORDER BY pages_created DESC
LIMIT 1000