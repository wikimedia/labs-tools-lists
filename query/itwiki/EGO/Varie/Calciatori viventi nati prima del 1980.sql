CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
    FROM page JOIN templatelinks ON page_id = tl_from
              JOIN categorylinks ON page_id = cl_from
              JOIN revision ON page_latest=rev_id
              JOIN text ON rev_text_id=old_id
    WHERE page_namespace = 0
      AND tl_namespace = 10
      AND cl_to = 'Persone_viventi'
      AND cl_to LIKE 'Calciatori%'
      AND NOT cl_to LIKE 'Nati_nel_198%'
      AND NOT cl_to LIKE 'Nati_nel_199%'
      AND NOT cl_to LIKE 'Nati_nel_2%'
      AND NOT old_text REGEXP ".*ex (?=calciatore).*";
    ORDER BY page_title;
