USE itwiki_p;
SET @counter = 0;
SELECT @counter := @counter +1, user_editcount, user_name
FROM (SELECT user_name, user_editcount
FROM user
WHERE user_id IN (
SELECT ug_user
FROM user_groups 
WHERE ug_group = 'bot')
OR user_name IN (
SELECT REPLACE(log_title, '_', ' ')
FROM logging
WHERE log_type = 'rights'
AND log_params LIKE '%bot%'
AND log_params NOT LIKE '%sysop%'
GROUP BY log_title)
GROUP BY user_name) sub
ORDER BY user_editcount DESC
LIMIT 1000