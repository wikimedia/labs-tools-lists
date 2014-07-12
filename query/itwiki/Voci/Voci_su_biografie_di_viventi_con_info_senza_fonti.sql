CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
    FROM page JOIN templatelinks ON page_id = tl_from
              JOIN categorylinks ON page_id = cl_from
    WHERE page_namespace = 0
      AND ( tl_title = 'Citazione_necessaria'
         OR tl_title = 'F' )
      AND tl_namespace = 10
      AND cl_to = 'Persone_viventi'
    ORDER BY page_title;
