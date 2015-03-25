CONNECT itwiki_p itwiki.labsdb;
SET @counter = 0;
SELECT @counter := @counter +1, user_editcount, user_name
FROM (SELECT user_name, user_editcount
FROM user, user_groups
WHERE user_id = ug_user
AND ug_group = "bot"
AND ug_group NOT LIKE "ipblock%"
GROUP BY user_name) sub
ORDER BY user_editcount DESC
LIMIT 1000