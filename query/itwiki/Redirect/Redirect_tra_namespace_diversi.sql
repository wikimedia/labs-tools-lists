CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT('# [[', ns_A.x_nsname, ':', page_title, ']] → [[', ns_B.x_nsname, ':', rd_title, ']]')
FROM page
JOIN redirect ON page_id = rd_from
JOIN s51223__lists_p.x_namespaces ns_A ON page_namespace = ns_A.x_nsnumber
JOIN s51223__lists_p.x_namespaces ns_B ON rd_namespace = ns_B.x_nsnumber
WHERE page_namespace <> rd_namespace
ORDER BY page_namespace, page_title;
