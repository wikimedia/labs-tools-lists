USE itwiki_p;
SELECT CONCAT("# [[", page_title, "]] - ", SUBSTRING(cl_to, -4, 4))
  FROM page, templatelinks, categorylinks
  WHERE page_namespace = 0
  AND page_id = tl_from
  AND page_id = cl_from
  AND tl_title = 'Vetrina'
  AND cl_to LIKE 'Voci_entrate_in_vetrina_nel_mese_di%'
  AND page_id IN (SELECT tl_from
    FROM templatelinks
	WHERE tl_namespace = 10
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
					'Cn', 'Citation_needed', 'S_sezione', 'Da_aggiornare'))
ORDER BY SUBSTRING(cl_to, -4, 4), page_title;
