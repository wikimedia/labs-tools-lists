CONNECT wikidatawiki_p wikidatawiki.labsdb;
SELECT CONCAT('* [[Q', ips_item_id, ']] - ', COUNT(ips_item_id)) 
FROM wb_items_per_site 
WHERE ips_site_id LIKE '%wiki'
AND NOT ips_site_id='wikidatawiki'
AND NOT ips_site_id='commonswiki'
GROUP BY ips_item_id 
HAVING COUNT(ips_item_id) > 49
AND ips_item_id NOT IN
(SELECT ips_item_id
FROM wb_items_per_site
WHERE ips_site_id='itwiki')
ORDER BY COUNT(ips_item_id) DESC;