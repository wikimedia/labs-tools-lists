CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", ns_name, ":", page_title, "]] (", page_len, ")")
FROM page
JOIN p50380g50614__lists.ns_it ON page_namespace = ns_id
WHERE page_namespace <> '0'
AND page_namespace <> '2'
AND page_namespace <> '3'
AND page_len < '5'
ORDER BY page_namespace, page_title;
