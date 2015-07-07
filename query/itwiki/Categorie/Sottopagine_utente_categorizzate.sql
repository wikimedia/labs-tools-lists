CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[Utente:", page_title, "]]" )
	FROM page
	WHERE page_namespace =2
		AND page_is_redirect =0
		AND page_title LIKE '%/%'
		AND page_id IN (
 			SELECT cl_from FROM categorylinks
 				WHERE cl_to NOT LIKE "Utent%"
 				AND cl_to NOT LIKE "Wikipedia%"
				AND cl_to NOT LIKE "Pagine_non_indicizzate")
	ORDER BY page_title;