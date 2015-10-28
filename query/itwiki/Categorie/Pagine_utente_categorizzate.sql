CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[Utente:", page_title, "]]" )
FROM page
WHERE page_namespace = 2
AND page_is_redirect = 0
AND page_title NOT LIKE '%/%'
AND page_id IN (
SELECT cl_from FROM categorylinks
WHERE cl_to NOT LIKE "Utenti%"
AND cl_to NOT LIKE "Wikipedia%"
AND cl_to NOT LIKE "Pagine_utente_protette%"
AND cl_to NOT LIKE "Pagine_non_indicizzate"
AND cl_to NOT LIKE "Soft_redirect"
AND cl_to NOT LIKE "Wikitraduttori%"
AND cl_to NOT LIKE "Wikigrafici"
AND cl_to NOT LIKE "Wikibibliotecari"
AND cl_to NOT LIKE "Progetto%"
AND cl_to NOT LIKE "Soci_Wikimedia_Italia"
AND cl_to NOT LIKE "Staff_della_Wikimedia_Foundation"
AND cl_to NOT LIKE "IP_noti"
AND cl_to NOT LIKE "Vandali_di_Wikipedia"
AND cl_to NOT LIKE "%bot%"
AND cl_to NOT LIKE "Template%"
AND cl_to NOT LIKE "Modelli_senza_data"
AND cl_to NOT LIKE "Errori_di_compilazione%"
AND cl_to NOT LIKE "Pagine_con_errori_nelle_espressioni"
AND cl_to NOT LIKE "Promemoria"
AND cl_to NOT LIKE "Sportivi_con_immagine_non_presente_su_Wikidata"
AND cl_to NOT LIKE "Strumenti_di_manutenzione"
AND cl_to NOT LIKE "Collaborazioni%"
AND cl_to NOT LIKE "Immagini%")
ORDER BY page_title;