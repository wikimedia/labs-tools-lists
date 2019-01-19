USE itwiki_p;
SET @counter = 0;
SELECT @counter := @counter +1, pages_created, rev_user_text
FROM (SELECT COUNT(*) as pages_created, rev_user_text
FROM page, revision
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
AND rev_user != 0
AND rev_user NOT IN (
SELECT ug_user
FROM user_groups 
WHERE ug_group = 'bot')
AND rev_user_text NOT IN (
SELECT REPLACE(log_title, '_', ' ')
FROM logging
WHERE log_type = 'rights'
AND log_params LIKE '%bot%'
AND log_params NOT LIKE '%sysop%'
GROUP BY log_title)
GROUP BY rev_user_text) sub
ORDER BY pages_created DESC
LIMIT 1000