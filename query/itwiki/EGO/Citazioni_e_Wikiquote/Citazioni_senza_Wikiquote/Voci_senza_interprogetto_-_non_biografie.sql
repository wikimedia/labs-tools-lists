CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]")
    FROM page
    JOIN templatelinks on tl_from=page_id
    WHERE page_namespace=0
        AND tl_namespace=10
        AND tl_title="Quote"
        AND page_id not IN (
            SELECT tl_from from templatelinks
                WHERE tl_namespace=10
                    AND tl_title="Interprogetto"
        )
        AND page_id not in (
            SELECT cl_from from categorylinks
                WHERE cl_to="Biografie"
        )
    ORDER BY page_title;