SELECT @counter := @counter +1, user_editcount, user_name
FROM (SELECT user_name, user_editcount
FROM user
WHERE user_id NOT IN (
SELECT ug_user
FROM user_groups 
WHERE ug_group = 'bot')
AND user_name NOT IN (
SELECT REPLACE(log_title, '_', ' ')
FROM logging
WHERE log_type = 'rights'
AND log_params LIKE '%bot%'
AND log_params NOT LIKE '%sysop%'
GROUP BY log_title)
GROUP BY user_name) sub
CROSS JOIN (SELECT @counter := 0) x
ORDER BY user_editcount DESC
LIMIT 1000