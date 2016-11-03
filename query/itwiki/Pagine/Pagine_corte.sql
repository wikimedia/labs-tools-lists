CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", x_nsname, ":", page_title, "]] (", page_len, ")")
FROM page
JOIN s51223__lists_p.x_namespaces ON page_namespace = x_nsnumber
WHERE page_namespace <> '0'
AND page_namespace <> '2'
AND page_namespace <> '3'
AND page_len < '5'
ORDER BY page_namespace, page_title;
