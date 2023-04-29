SELECT CONCAT('# [[Template:', page_title, ']]')
  FROM page JOIN redirect ON page_id = rd_from
  WHERE page_namespace = 10 AND rd_namespace = 10
    AND NOT EXISTS (SELECT * 
      FROM page AS p JOIN pagelinks ON p.page_id = pl_from 
        WHERE p.page_namespace IN (0, 4, 10, 12, 100, 102) AND pl_namespace = 0 AND pl_title = page.page_title)
    AND NOT EXISTS (SELECT * 
      FROM page AS q JOIN templatelinks ON q.page_id = tl_from 
        WHERE q.page_namespace IN (0, 4, 10, 12, 100, 102) AND tl_namespace = 10 AND tl_title = page.page_title)
  ORDER BY page_title;