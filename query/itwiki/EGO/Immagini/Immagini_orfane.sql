CONNECT itwiki_p itwiki.labsdb;
SELECT concat("# [[:Immagine:", page.page_title, "]]")
  FROM page JOIN templatelinks ON page.page_id = templatelinks.tl_from
  WHERE templatelinks.tl_title = 'EDP'
    AND page.page_namespace = 6
    AND page.page_title NOT IN (
      SELECT DISTINCT imagelinks.il_to FROM imagelinks
    )
  ORDER BY page.page_title;