CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('* [[', x_nsname, ':', page_title, ']] - [[:File:', il_to, ']]')
  FROM page, imagelinks, s51223__lists_p.x_namespaces
  WHERE page_namespace NOT IN (0, 1, 2, 6)
	AND page_namespace = x_nsnumber
    AND page_id = il_from
    AND il_to
      IN (SELECT page_title
        FROM page JOIN templatelinks ON page_id = tl_from
        WHERE page_namespace = 6
          AND tl_namespace = 10
          AND tl_title='EDP')
  ORDER BY page_namespace, page_title, il_to;
