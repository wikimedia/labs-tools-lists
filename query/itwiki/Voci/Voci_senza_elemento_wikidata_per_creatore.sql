USE itwiki_p;
SELECT CONCAT('# [[Utente:', actor_name, ']] (', COUNT(*), ')')
FROM page, revision JOIN actor ON actor_id = rev_actor
WHERE page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'wikibase_item')
AND page_namespace = 0
AND page_is_redirect = 0
AND page_id = rev_page
AND rev_parent_id = 0
GROUP BY actor_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 1000;