SET @counter = 0;
SELECT @counter := @counter +1, user_editcount, user_name
FROM (SELECT user_name, user_editcount
FROM user
where user_editcount > 0 and user_editcount <= 10
GROUP BY user_name) sub
ORDER BY user_editcount ASC
LIMIT 1000
