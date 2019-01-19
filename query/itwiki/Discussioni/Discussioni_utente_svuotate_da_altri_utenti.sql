USE itwiki_p;
SELECT CONCAT( "# [[Discussioni_utente:", page_title, "]]" )
FROM page
JOIN revision ON rev_id = page_latest
WHERE page_namespace LIKE 3
AND page_len LIKE 0
AND page_title NOT LIKE "%/%"
AND rev_user_text NOT LIKE page_title;