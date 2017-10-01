USE itwiki_p;
SELECT CONCAT("# [[:Categoria:", page_title, "]]")
FROM page
WHERE page_namespace = 14
AND page_id IN
(SELECT cl_from
FROM categorylinks
WHERE cl_to = 'Collegamento_interprogetto_a_Wikimedia_Commons_presente_ma_assente_da_Wikidata')
AND page_id NOT IN
(SELECT ll_from
FROM langlinks)
ORDER BY page_title;
