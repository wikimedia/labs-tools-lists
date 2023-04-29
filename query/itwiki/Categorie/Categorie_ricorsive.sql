SELECT concat("# [[:Categoria:" , cl_to , "]]")
 	FROM categorylinks, page
 	WHERE page_namespace =14
 		AND page_id = cl_from
 		AND page_title = cl_to;
