SELECT CONCAT( "# [[Utente:", page_title, "]]" )
FROM page
WHERE page_namespace = 2
AND page_is_redirect = 0
AND page_id IN (
SELECT cl_from FROM categorylinks
WHERE cl_to NOT LIKE "Utent%"
AND cl_to NOT LIKE "Aggiornare_subito"
AND cl_to NOT LIKE "%bot%"
AND cl_to NOT LIKE "Cancellazioni%"
AND cl_to NOT LIKE "Collaborazioni%"
AND cl_to NOT LIKE "Crediti"
AND cl_to NOT LIKE "Dividere"
AND cl_to NOT LIKE "Draft"
AND cl_to NOT LIKE "Elenchi_generati_offline%"
AND cl_to NOT LIKE "Errori%"
AND cl_to NOT LIKE "File_privi_di_descrizione"
AND cl_to NOT LIKE "GastroBot"
AND cl_to NOT LIKE "Immagini%"
AND cl_to NOT LIKE "IP_noti"
AND cl_to NOT LIKE "Liste_in_aggiornamento"
AND cl_to NOT LIKE "Modelli_senza_data"
AND cl_to NOT LIKE "Organizzare"
AND cl_to NOT LIKE "Pagine_che%"
AND cl_to NOT LIKE "Pagine_con_collegamenti%"
AND cl_to NOT LIKE "Pagine_con_chiave%"
AND cl_to NOT LIKE "Pagine_con_coordinate%"
AND cl_to NOT LIKE "Pagine_con_errori%"
AND cl_to NOT LIKE "Pagine_con_grafici%"
AND cl_to NOT LIKE "Pagine_con_link%"
AND cl_to NOT LIKE "Pagine_con_tag%"
AND cl_to NOT LIKE "Pagine_con_template%"
AND cl_to NOT LIKE "Pagine_contenenti%"
AND cl_to NOT LIKE "Pagine_di_servizio%"
AND cl_to NOT LIKE "Pagine_non_indicizzate"
AND cl_to NOT LIKE "Pagine_per_l'accessorio%"
AND cl_to NOT LIKE "Pagine_protette%"
AND cl_to NOT LIKE "Pagine_utente%"
AND cl_to NOT LIKE "PD-Requisiti"
AND cl_to NOT LIKE "Portali_in_preparazione"
AND cl_to NOT LIKE "Progetti_in_preparazione"
AND cl_to NOT LIKE "Promemoria"
AND cl_to NOT LIKE "Pubbliche_relazioni"
AND cl_to NOT LIKE "Progetto%"
AND cl_to NOT LIKE "Razze di Wikipediani"
AND cl_to NOT LIKE "Saggi_su_Wikipedia"
AND cl_to NOT LIKE "Sandbox%"
AND cl_to NOT LIKE "Scherzi_e_STUBidaggini"
AND cl_to NOT LIKE "Segnalazioni_automatiche%"
AND cl_to NOT LIKE "Soci_Wikimedia_Italia"
AND cl_to NOT LIKE "Staff_della_Wikimedia_Foundation"
AND cl_to NOT LIKE "Soft_redirect"
AND cl_to NOT LIKE "Strumenti_di_manutenzione"
AND cl_to NOT LIKE "Studenti_progetto%"
AND cl_to NOT LIKE "Suggerimento_immagini"
AND cl_to NOT LIKE "Template%"
AND cl_to NOT LIKE "Manuali_dei_template"
AND cl_to NOT LIKE "Tabelle%"
AND cl_to NOT LIKE "Tradurre%"
AND cl_to NOT LIKE "Vandali%"
AND cl_to NOT LIKE "Voci_con_template%"
AND cl_to NOT LIKE "Voci_monitorate%"
AND cl_to NOT LIKE "Voci_risultanti_da_scorporo"
AND cl_to NOT LIKE "Voci_tradotte%"
AND cl_to NOT LIKE "Wiki%"
AND cl_to NOT LIKE "%Wikidata%")
ORDER BY page_title;