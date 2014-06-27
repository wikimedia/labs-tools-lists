CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']] - [[', rd_title, ']] ([[Speciale:PuntanoQui/', page_title, ']])')
  FROM page JOIN redirect ON page_id=rd_from
  WHERE page_namespace=0 AND rd_namespace = 0
    AND NOT EXISTS ( SELECT * 
      FROM page AS p JOIN pagelinks ON p.page_id = pl_from 
        WHERE p.page_namespace IN (0, 4, 10, 12, 100, 102) AND pl_namespace = 0 AND pl_title = page.page_title)
  ORDER BY page_title
  LIMIT 7500;
