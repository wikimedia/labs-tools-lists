SELECT @counter := @counter +1, user_editcount, user_name
FROM (SELECT user_name, user_editcount
FROM user
GROUP BY user_name) sub
CROSS JOIN (SELECT @counter := 0) x
ORDER BY user_editcount DESC
LIMIT 1000