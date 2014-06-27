CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[Discussioni_utente:", page_title, "]]" )
FROM page
JOIN revision ON rev_id = page_latest
WHERE page_namespace LIKE 3
AND page_len LIKE 0
AND rev_user_text LIKE page_title;