CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', x_nsname, ':', page_title, ']]')
  FROM page AS p1 JOIN s51223__lists_p.x_namespaces ON page_namespace = x_nsnumber
  WHERE page_is_redirect = 1 AND page_namespace IN (1, 11, 15, 101, 103)
    AND NOT EXISTS (SELECT *
      FROM pagelinks JOIN page AS p2 ON pl_from = p2.page_id
      WHERE pl_title = p1.page_title AND pl_namespace = p1.page_namespace
        AND p2.page_namespace != 4 AND p2.page_title != 'Elenchi_generati_offline/Redirect_a_discussioni')
  ORDER BY x_nsnumber, page_title;
