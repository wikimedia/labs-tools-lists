CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('* [[', ns_name, ':', page_title, ']] - [[:File:', il_to, ']]')
  FROM page, imagelinks, p50380g50614__lists.ns_it
  WHERE page_namespace NOT IN (0, 1, 2, 6)
	AND page_namespace = ns_id
    AND page_id = il_from
    AND il_to
      IN (SELECT page_title
        FROM page JOIN templatelinks ON page_id = tl_from
        WHERE page_namespace = 6
          AND tl_namespace = 10
          AND tl_title='EDP')
  ORDER BY page_namespace, page_title, il_to;
