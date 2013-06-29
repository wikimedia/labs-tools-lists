CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT('* [[', page.page_title, ']]') AS "Articles"
  FROM page JOIN imagelinks ON il_from=page_id
  JOIN page AS image ON image.page_namespace=6 AND image.page_title=il_to
  JOIN categorylinks ON cl_from=image.page_id
  LEFT JOIN templatelinks ON tl_from=page.page_id AND tl_namespace = 10 AND tl_title IN (
    'Film', 'StagioniTV', 'Fumetto_e_animazione', 'Episodio_SerieTV', 'ProgrammaTV', 
    'FictionTV', 'Personaggio', 'Infobox_personaggio_fittizio', 'Digimon_Infobox', 'Album', 
    'Gamebox', 'Sistema_operativo', 'Software', 'Programma', 'Tour_musicale', 'ReteTV',
    'Personaggi_di_BLEACH', 'Personaggi_Street_Fighter', 'Kenshin'
  )
  LEFT JOIN pagelinks ON pl_namespace=page.page_namespace AND pl_title=page.page_title AND pl_from=(
    SELECT page_id
    FROM page
    WHERE page_namespace=4 AND page_title='Elenchi_generati_offline/Screenshot/Whitelist'
  )
  WHERE page.page_namespace = 0
    AND cl_to LIKE "Screenshot_copy%"
    AND tl_from IS NULL
    AND pl_from IS NULL
  ORDER BY 1;