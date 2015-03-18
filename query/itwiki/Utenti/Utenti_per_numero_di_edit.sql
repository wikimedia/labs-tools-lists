CONNECT itwiki_p itwiki.labsdb;
SELECT user_name, user_editcount
FROM user, user_groups
WHERE user_id = ug_user
AND ug_group NOT LIKE "bot"
AND ug_group NOT LIKE "ipblock%"
GROUP BY user_name
ORDER BY user_editcount DESC
LIMIT 1000