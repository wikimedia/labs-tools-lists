CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', nstalk.ns_name, ':', page.page_title, ']] (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
FROM redirect
JOIN page ON rd_from = page_id
INNER JOIN page AS disc ON page.page_title = disc.page_title
JOIN revision ON disc.page_latest = rev_id
JOIN p50380g50614__lists.ns_it AS nstalk ON disc.page_namespace = nstalk.ns_id
JOIN p50380g50614__lists.ns_it AS nspage ON (disc.page_namespace - 1) = nspage.ns_id
  WHERE page.page_namespace = 0
    AND disc.page_namespace = 1
    AND page.page_is_redirect = 1
    AND disc.page_is_redirect = 0
ORDER BY nstalk.ns_name, rev_timestamp, page.page_title;
