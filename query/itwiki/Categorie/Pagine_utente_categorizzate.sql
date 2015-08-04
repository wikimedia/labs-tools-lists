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
AND cl_to NOT LIKE "Soci_Wikimedia_Italia"
AND cl_to NOT LIKE "Staff_della_Wikimedia_Foundation"
AND cl_to NOT LIKE "IP_noti"
AND cl_to NOT LIKE "Vandali_di_Wikipedia"
AND cl_to NOT LIKE "%bot%")
ORDER BY page_title;