CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']] -> [[', rd_title, ']]')
  FROM page JOIN redirect ON page_id = rd_from
  WHERE page_namespace = 0 
    AND rd_namespace = 0
    AND rd_title like CONCAT(page_title, '_(%')
  ORDER BY page_title;