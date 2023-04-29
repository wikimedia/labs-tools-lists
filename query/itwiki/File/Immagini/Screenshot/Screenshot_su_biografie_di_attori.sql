SELECT DISTINCT CONCAT( '* [[', page_title, ']]' )
FROM page JOIN imagelinks ON page_id = il_from
WHERE page_namespace = 0
  AND page_is_redirect =0
  AND page_id
    IN (
      SELECT cl_from
      FROM categorylinks
      WHERE cl_to LIKE "Attori%"
        OR cl_to LIKE "Cabarettisti%"
        OR cl_to LIKE "Comici%"
        OR cl_to LIKE "Mimi%"
        OR cl_to LIKE "Trasformisti%"
    )
  AND page_id
    NOT IN (
      SELECT cl_from
      FROM categorylinks
      WHERE cl_to LIKE "%immaginari"
        OR cl_to LIKE "%immaginarie"
    )
  AND il_to
    IN (
      SELECT page_title
      FROM page
      JOIN categorylinks ON page_id = cl_from
      WHERE cl_to LIKE "Screenshot_copy%"
      AND page_namespace = 6
    )
    AND (page_namespace, page_title)
      NOT IN (SELECT pl_namespace, pl_title
        FROM pagelinks JOIN page ON pl_from = page_id
        WHERE page_namespace=4 
          AND page_title = 'Elenchi_generati_offline/Screenshot/Whitelist')
  ORDER BY page_title;