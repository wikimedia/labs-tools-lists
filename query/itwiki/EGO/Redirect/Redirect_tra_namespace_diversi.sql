CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT('# [[', ns_it_A.ns_name, ':', page_title, ']] → [[', ns_it_B.ns_name, ':', rd_title, ']]')
FROM page
JOIN redirect ON page_id = rd_from
JOIN p50380g50614__lists.ns_it ns_it_A ON page_namespace = ns_it_A.ns_id
JOIN p50380g50614__lists.ns_it ns_it_B ON rd_namespace = ns_it_B.ns_id
WHERE page_namespace <> rd_namespace
ORDER BY page_namespace, page_title;
