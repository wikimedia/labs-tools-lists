CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[Discussione:", page_title, "]] (", page_len, ")")
FROM (SELECT page_title, page_len
FROM page JOIN revision ON page_id = rev_page
WHERE page_is_redirect=0
AND page_namespace=1
AND page_len < 25
AND NOT EXISTS (SELECT *
FROM templatelinks
WHERE tl_from = page_id AND tl_namespace = 10 AND tl_title IN ('FDQMI', 'FDQOI') )
GROUP BY page_id, rev_user) AS t
GROUP BY page_title
HAVING count(*) = 1
ORDER BY page_title;
