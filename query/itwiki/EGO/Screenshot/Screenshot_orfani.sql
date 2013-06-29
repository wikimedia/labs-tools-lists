SELECT concat("#[[:Immagine:", page.page_title, "]]")
  FROM page JOIN categorylinks ON page_id = cl_from
  WHERE cl_to LIKE 'Screenshot_copy%'
    AND page_namespace = 6
    AND page.page_title NOT IN (
      SELECT DISTINCT il_to FROM imagelinks
    )
  LIMIT 1;