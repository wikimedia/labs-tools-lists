USE itwiki_p;
SELECT CONCAT("# [[Utente:", rev_user_text, "]] (", COUNT(*), ")")
FROM revision
WHERE rev_page IN (
SELECT tl_from
FROM templatelinks
WHERE tl_title = 'Tradotto_da'
AND tl_namespace = 10
AND tl_from_namespace = 1)
AND rev_parent_id = 0
AND rev_timestamp > NOW() - INTERVAL 2 YEAR
GROUP BY rev_user_text
HAVING COUNT(*) >= 10
ORDER BY COUNT(*) DESC;
