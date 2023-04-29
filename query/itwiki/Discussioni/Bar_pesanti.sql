SELECT CONCAT("# [[Discussioni_progetto:", page_title, "]] - ", page_len)
FROM pagelinks
JOIN page ON page_namespace = pl_namespace AND page_title = pl_title
WHERE pl_from = 77179 AND pl_namespace = 103 AND page_len >= 200000
ORDER BY page_len DESC;