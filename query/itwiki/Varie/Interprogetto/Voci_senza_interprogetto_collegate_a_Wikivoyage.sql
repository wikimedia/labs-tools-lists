USE itwiki_p;
SELECT DISTINCT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_id NOT IN (
SELECT tl_from
FROM templatelinks
WHERE tl_namespace = 10
AND (tl_title = 'Interprogetto'
OR tl_title = 'Ip'
OR tl_title = 'Disambigua' ) )
AND page_title IN (
SELECT REPLACE(WIKI.ips_site_page, ' ', '_')
FROM wikidatawiki_p.wb_items_per_site WIKI, wikidatawiki_p.wb_items_per_site EXT
WHERE WIKI.ips_item_id = EXT.ips_item_id
AND WIKI.ips_site_id = 'itwiki'
AND EXT.ips_site_id = 'itwikivoyage' )
ORDER BY page_title;
