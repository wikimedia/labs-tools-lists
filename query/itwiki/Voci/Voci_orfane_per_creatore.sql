CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[Utente:', rev_user_text, ']] (', COUNT(*), ')')
FROM page, revision
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
AND page_title NOT IN
(SELECT pl_title
FROM pagelinks
WHERE pl_namespace = 0
AND pl_from NOT IN
(SELECT page_id
FROM page
WHERE page_namespace <> 0)
AND pl_from NOT IN
(SELECT cl_from
FROM categorylinks, pagelinks
WHERE cl_to = pl_title
AND pl_namespace = 14
AND pl_from = 4195411)) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
AND page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
AND page_id NOT IN
(SELECT cl_from
FROM categorylinks, pagelinks
WHERE cl_to = pl_title
AND pl_namespace = 14
AND pl_from = 4195411) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
GROUP BY rev_user_text
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
