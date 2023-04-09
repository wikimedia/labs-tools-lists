USE itwiki_p;
SELECT CONCAT('# [[Utente:', actor_name, ']] (', COUNT(*), ')')
FROM page, revision
JOIN actor ON actor_id = rev_actor
WHERE page_is_redirect = 0
AND page_namespace = 0
AND page_id = rev_page
AND rev_parent_id = 0
AND page_id NOT IN
(SELECT ll_from
FROM langlinks)
GROUP BY actor_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 1000;