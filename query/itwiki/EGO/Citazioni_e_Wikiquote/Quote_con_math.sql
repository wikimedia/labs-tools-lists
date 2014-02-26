CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
	FROM page
	JOIN revision ON page_id=rev_page
	JOIN text ON rev_text_id=old_id
    WHERE page_namespace='0'
    	AND old_text REGEXP "{{[Qq]uote.*\\|<math>.*</math>.*}}"
    ORDER BY page_title;