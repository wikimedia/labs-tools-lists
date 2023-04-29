SET @counter = 0;
SELECT @counter := @counter +1, pages_created, actor_name
FROM (SELECT COUNT(*) as pages_created, actor_name
FROM page, revision, actor
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
AND actor_id = rev_actor
AND actor_user NOT IN (
SELECT ug_user
FROM user_groups 
WHERE ug_group = 'bot')
AND actor_name NOT IN (
SELECT REPLACE(log_title, '_', ' ')
FROM logging
WHERE log_type = 'rights'
AND log_params LIKE '%bot%'
AND log_params NOT LIKE '%sysop%'
GROUP BY log_title)
GROUP BY actor_name) sub
ORDER BY pages_created DESC
LIMIT 1000;