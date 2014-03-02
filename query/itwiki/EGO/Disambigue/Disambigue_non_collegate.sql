SELECT CONCAT("# [[", P.page_title, "]]")
FROM page as P
LEFT JOIN templatelinks as PT
  ON PT.tl_from = P.page_id
    AND PT.tl_namespace = 10
    AND PT.tl_title IN ( "Disambigua", "Sigla", "Sigla2", "Sigla3", "Sigla4", "Cogni", "Nota disambigua", "Nota disambigua2" )
LEFT JOIN pagelinks
  ON pl_namespace = 0
    AND pl_title = P.page_title
LEFT JOIN page as G
  ON G.page_id = pl_from
LEFT JOIN templatelinks as GT
  ON GT.tl_from = G.page_id
    AND GT.tl_namespace = 10
    AND GT.tl_title IN ( "Disambigua", "Sigla", "Sigla2", "Sigla3", "Sigla4", "Cogni", "Nota disambigua", "Nota disambigua2" )
WHERE P.page_namespace = 0
  AND P.page_is_redirect = 0
  AND P.page_title LIKE "%_(%)"
  AND PT.tl_from IS NULL
  AND pl_from IS NULL
ORDER BY P.page_title;
