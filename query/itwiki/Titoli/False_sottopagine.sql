SELECT DISTINCT CONCAT('* [[', p1.page_title, ']] - [[', SUBSTRING_INDEX(p1.page_title, '/', 1), ']]')
FROM page as p1
WHERE p1.page_namespace = 0
  AND p1.page_is_redirect = 0
  AND p1.page_title LIKE '%/%'
  AND p1.page_title
    NOT IN (SELECT pl_title
      FROM pagelinks JOIN page ON pl_from = page_id
      WHERE pl_namespace=0
        AND page_namespace=4
        AND page_title = 'Elenchi_generati_offline/False_sottopagine/Whitelist')
ORDER BY p1.page_title;
