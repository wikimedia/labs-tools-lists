CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT("# [[", x_nsname, ":", page_title, "]], (", DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ")")
FROM page, revision, s51223__lists_p.x_namespaces
WHERE page_id = rev_page
AND page_namespace = x_nsnumber
AND page_is_new = 1
AND page_is_redirect = 0
AND rev_user = 0
AND page_namespace <> 0
ORDER BY rev_timestamp, page_namespace, page_title
LIMIT 5000;
