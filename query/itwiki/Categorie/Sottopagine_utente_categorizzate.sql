CONNECT itwiki_p itwiki.labsdb;
SELECT concat( "# [[Utente:", page_title, "]]" )
	FROM page
	WHERE page_namespace =2
		AND page_is_redirect =0
		AND page_title LIKE '%/%'
		AND page_id IN (
 			SELECT cl_from FROM categorylinks
 				WHERE cl_to NOT LIKE "Utent%"
 					AND cl_to NOT LIKE "Wikipedia%")
	ORDER BY page_title;