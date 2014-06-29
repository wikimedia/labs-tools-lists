CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
  FROM page, templatelinks
  WHERE page_namespace = 0
  AND page_id = tl_from
  AND (tl_title = 'Voce_di_qualità'
       OR tl_title = 'Vdq'
       OR tl_title = 'VdQ')
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
  ORDER BY page_title;
