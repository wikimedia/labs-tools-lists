CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
  FROM page JOIN templatelinks ON page_id = tl_from
  WHERE tl_namespace = 10 AND tl_title = 'T'
    AND page_namespace=0 AND page_is_redirect=0
    AND page_title NOT IN (SELECT page_title
                             FROM page JOIN templatelinks ON page_id = tl_from
                             WHERE tl_namespace = 10 AND tl_title = 'Tradotto_da'
                               AND page_namespace=1
                               AND page_is_redirect=0)
  ORDER BY page_title;
