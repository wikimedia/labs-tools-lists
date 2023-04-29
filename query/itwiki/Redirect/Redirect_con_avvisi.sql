SELECT CONCAT("# [[", page_title, "]]")
FROM page, templatelinks
WHERE page_id = tl_from
AND tl_namespace = 10
AND page_namespace = 0
AND tl_title IN ('S', 'Stub', 'W', 'PW', 'Wikificare','A', 'C',
                       'Da_controllare', 'E', 'T', 'T_sezione', 'P', 'V',
                       'Bufala', 'L', 'Localismo', 'F', 'Senza_fonti',
                       'Senzafonti','U', 'Merge', 'Da_unire', 'Correggere',
                       'Da_correggere', 'Errori_grammaticali', 'NN', 'N',
                       'Controlcopy', 'Voci_senza_uscita', 'Categorizzare',
                       'Tmp', 'Manca_template', 'Tradurre', 'O', 'Dividi',
                       'Chiarire', 'Non_chiaro', 'Da_chiarire', 'D',
                       'Recentismo', 'Organizzare', 'Finzione', 'Fact',
                       'Citazione_necessaria', 'Senza fonte', 'CN', 'Sf',
                       'Cn', 'Citation_needed', 'S_sezione', 'Da_aggiornare')
AND page_is_redirect = 1
GROUP BY page_id
ORDER BY page_title;
