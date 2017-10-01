CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[{{ns:', disc.page_namespace, '}}:', page.page_title, ']] (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
FROM redirect
JOIN page ON rd_from = page_id
INNER JOIN page AS disc ON page.page_title = disc.page_title
JOIN revision ON disc.page_latest = rev_id
  WHERE page.page_namespace = 0
    AND disc.page_namespace = 1
    AND page.page_is_redirect = 1
    AND disc.page_is_redirect = 0
ORDER BY disc.page_namespace, rev_timestamp, page.page_title;
