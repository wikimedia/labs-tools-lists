SELECT DISTINCT CONCAT("# [[", page_title, "]]")
  FROM page JOIN categorylinks ON page_id = cl_from
  WHERE
    page_namespace=0
      AND page_is_redirect=0
      AND cl_to LIKE 'Brani_musicali%'
      AND page_id IN (SELECT tl_from
                      FROM templatelinks
                      WHERE tl_namespace=10 AND tl_title='Album')
  ORDER BY page_title;
