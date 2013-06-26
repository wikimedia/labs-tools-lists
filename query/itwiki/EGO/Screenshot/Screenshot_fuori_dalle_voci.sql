CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT( '* [[', ns_name, ':', page_title, ']]' )
  FROM page JOIN toolserver.namespace ON page_namespace = ns_id
    JOIN imagelinks ON page_id = il_from
  WHERE page_namespace NOT IN (0,6)
    AND dbname = 'itwiki_p'
    AND il_to
      IN (SELECT page_title
        FROM page JOIN categorylinks ON page_id = cl_from
        WHERE cl_to LIKE "Screenshot_copy%"
          AND page_namespace =6)
    AND (page_namespace, page_title)
      NOT IN (SELECT pl_namespace, pl_title
        FROM pagelinks JOIN page ON pl_from = page_id
        WHERE page_namespace=4 
          AND page_title = 'Elenchi_generati_offline/Screenshot/Whitelist')
  ORDER BY ns_name, page_title;