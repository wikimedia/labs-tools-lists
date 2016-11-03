CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', nstalk.x_nsname, ':', page.page_title, ']] (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
FROM redirect
JOIN page ON rd_from = page_id
INNER JOIN page AS disc ON page.page_title = disc.page_title
JOIN revision ON disc.page_latest = rev_id
JOIN s51223__lists_p.x_namespaces AS nstalk ON disc.page_namespace = nstalk.x_nsnumber
JOIN s51223__lists_p.x_namespaces AS nspage ON (disc.page_namespace - 1) = nspage.x_nsnumber
  WHERE page.page_namespace = 0
    AND disc.page_namespace = 1
    AND page.page_is_redirect = 1
    AND disc.page_is_redirect = 0
ORDER BY nstalk.x_nsname, rev_timestamp, page.page_title;
