CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT('# [[{{ns:', page_namespace, '}}:', page_title, ']] → [[{{ns:', rd_namespace, '}}:', rd_title, ']]')
FROM page
JOIN redirect ON page_id = rd_from
WHERE page_namespace <> rd_namespace
ORDER BY page_namespace, page_title;
