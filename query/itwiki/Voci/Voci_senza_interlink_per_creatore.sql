USE itwiki_p;
SELECT CONCAT('# [[Utente:', rev_user_text, ']] (', COUNT(*), ')')
FROM page, revision
LEFT JOIN langlinks ON ll_from = rev_page
WHERE page_is_redirect = 0
AND page_namespace = 0
AND page_id = rev_page
AND rev_parent_id = 0
AND ll_from IS NULL
GROUP BY rev_user_text
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 1000;