CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[Template:", page_title, "]]")  
  FROM (SELECT REPLACE(page_title, '/man', '') AS page_title 
    FROM page 
    WHERE page_namespace = 10 
      AND page_title LIKE '%/man') AS t1
  WHERE page_title NOT IN (SELECT page_title 
    FROM (SELECT p2.page_id AS page_id, p2.page_title AS page_title 
      FROM page AS p1, page AS p2 
      WHERE p1.page_title = CONCAT(p2.page_title, "/man") 
        AND p1.page_namespace = 10 
        AND p1.page_namespace = p2.page_namespace) AS p 
    JOIN templatelinks ON page_id = tl_from WHERE tl_title = "Man");
