USE itwiki_p;
SELECT CONCAT("* [[", page_title, "]] (", LENGTH(page_title), ")" )
    FROM page
    WHERE page_namespace = 0
        AND page_is_redirect = 0
        AND LENGTH(page_title) > 70
    ORDER BY LENGTH(page_title) DESC;
