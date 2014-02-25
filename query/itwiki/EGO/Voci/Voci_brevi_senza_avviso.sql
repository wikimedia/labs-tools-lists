CONNECT itwiki_p itwiki.labsdb;
SELECT IF( EXISTS(SELECT * FROM templatelinks WHERE tl_from=page_id AND tl_namespace=10 AND tl_title='S'),
         CONCAT('# [[', page_title, ']] - ', page_len, ' (Stub)'), CONCAT('# [[', page_title, ']] - ', page_len) )
  FROM page
  WHERE page_namespace = 0 AND page_is_redirect = 0
    AND page_len < 250
    AND page_id NOT IN ( SELECT cl_from
      FROM categorylinks
      WHERE cl_to = 'Voci_protette'
        OR cl_to LIKE 'Da_trasferire%' 
        OR cl_to = 'Voci_trasferite' 
        OR cl_to = 'Disambigua' 
        OR cl_to LIKE 'Combinazioni_di%' 
        OR cl_to LIKE 'Aiutare%' 
        OR cl_to LIKE 'Liste_%' )
  ORDER BY page_len, page_title;
