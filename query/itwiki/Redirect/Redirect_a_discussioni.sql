USE itwiki_p;
SELECT CONCAT('# [[{{ns:', page_namespace, '}}:', page_title, ']]')
  FROM page AS p1
  WHERE page_is_redirect = 1 AND page_namespace IN (1, 11, 15, 101, 103)
    AND NOT EXISTS (SELECT *
      FROM pagelinks JOIN page AS p2 ON pl_from = p2.page_id
      WHERE pl_title = p1.page_title AND pl_namespace = p1.page_namespace
        AND p2.page_namespace != 4 AND p2.page_title != 'Elenchi_generati_offline/Redirect_a_discussioni')
  ORDER BY page_namespace, page_title;
