USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']] --> [[Template:', pl_title, ']]')
FROM page, pagelinks
WHERE page_is_redirect = 1
AND page_namespace = 0
AND pl_from = page_id
AND pl_title IN
    (SELECT page_title
    FROM page AS tl
    WHERE page_namespace = 10
    AND NOT EXISTS
        (SELECT *
        FROM page
        WHERE page_namespace = 0
        AND page_title = tl.page_title))
ORDER BY page_title;
