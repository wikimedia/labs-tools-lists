CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[", page_title, "]]" )
     FROM page
     JOIN templatelinks ON tl_from = page_id
     WHERE page_namespace = 0
          AND tl_namespace = 10
          AND tl_title = "Quote"
          AND page_id IN (
               SELECT page_id
                    FROM page
                    JOIN templatelinks ON page_id = tl_from
                    JOIN text ON page_latest = old_id
                    WHERE tl_namespace =10
                         AND tl_title = "Interprogetto"
                         AND old_text NOT REGEXP ".*{{[Ii]nterprogetto.*\\|q.*}}.*"
          )
     ORDER BY page_title;