CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('#[[', page_title, ']] - ', count(*)) 
  FROM langlinks JOIN page on ll_from = page_id 
  WHERE page_namespace = 0 AND page_is_redirect = 0 
    AND NOT EXISTS (
      SELECT * FROM langlinks as t 
        WHERE t.ll_lang='en' and t.ll_from = langlinks.ll_from) 
  GROUP BY ll_from 
  ORDER BY count(*) DESC, page_title
  LIMIT 1000;