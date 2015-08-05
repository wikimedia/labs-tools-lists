CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[Utente:", page_title, "]]" )
FROM page
WHERE page_namespace = 2
AND page_is_redirect = 0
AND page_title LIKE '%/%'
AND page_id IN (
SELECT cl_from FROM categorylinks
WHERE cl_to NOT LIKE "Utent%"
AND cl_to NOT LIKE "Wikipedia%"
AND cl_to NOT LIKE "Pagine_non_indicizzate"
AND cl_to NOT LIKE "Sportivi_con_immagine_non_presente_su_Wikidata"
AND cl_to NOT LIKE "Wiki-Umorismo"
AND cl_to NOT LIKE "Wikitraduttori%"
AND cl_to NOT LIKE "Voci_tradotte%"
AND cl_to NOT LIKE "Template_complessi"
AND cl_to NOT LIKE "Progetti_in_preparazione"
AND cl_to NOT LIKE "Portali_in_preparazione"
AND cl_to NOT LIKE "Template_scherzi_e_STUBidaggini"
AND cl_to NOT LIKE "Promemoria"
AND cl_to NOT LIKE "Errori_di_compilazione%"
AND cl_to NOT LIKE "Progetto%"
AND cl_to NOT LIKE "Liste_in_aggiornamento"
AND cl_to NOT LIKE "Segnalazioni_automatiche%"
AND cl_to NOT LIKE "Voci_con_template%"
AND cl_to NOT LIKE "Pagine_con_errori_nelle_espressioni")
ORDER BY page_title;