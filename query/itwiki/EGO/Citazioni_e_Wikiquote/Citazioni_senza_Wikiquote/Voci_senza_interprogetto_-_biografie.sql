CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
     FROM page
     JOIN templatelinks on tl_from=page_id
     JOIN categorylinks on cl_from=page_id
     WHERE page_namespace=0
          AND  tl_namespace=10
          AND  tl_title="Quote"
          AND  cl_to="Biografie"
          AND  page_id not IN (
               SELECT tl_from from templatelinks
               WHERE  tl_namespace=10
                    AND    tl_title="Interprogetto"
          )
     ORDER BY page_title;