CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', p1.page_title, ']] - [[Discussione:', p1.page_title, ']]')
FROM page AS p1 JOIN templatelinks ON p1.page_id = tl_from, page AS p2
WHERE p1.page_namespace = 1
AND p1.page_is_redirect = 0
AND tl_title = 'Tradotto_da'
AND p1.page_title = p2.page_title
AND p2.page_namespace = 0
AND p2.page_is_redirect = 0
AND p2.page_id NOT IN
(SELECT ll_from
FROM langlinks)
AND p2.page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
AND p2.page_title NOT IN
(SELECT pl_title
FROM pagelinks
WHERE pl_from = 5395952) /* Wikipedia:Elenchi generati offline/Voci tradotte senza interlink/Whitelist */
ORDER BY p2.page_title;