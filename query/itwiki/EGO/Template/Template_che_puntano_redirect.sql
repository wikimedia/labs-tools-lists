CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[Template:", p1.page_title, "]] punta al redirect [[", p2.page_title, "]]") 
  FROM page AS p1 
    JOIN pagelinks ON p1.page_id = pl_from
    JOIN page as p2 ON pl_title = p2.page_title 
      AND pl_namespace = p2.page_namespace
  WHERE p1.page_namespace = 10 
    AND p2.page_namespace = 0 
    AND p1.page_is_redirect = 0 
    AND p2.page_is_redirect = 1
    AND p1.page_title NOT LIKE '%/man';