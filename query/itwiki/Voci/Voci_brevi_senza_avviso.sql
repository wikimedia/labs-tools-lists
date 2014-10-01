CONNECT itwiki_p itwiki.labsdb;
SELECT IF( EXISTS(SELECT * FROM templatelinks WHERE tl_from=page_id AND tl_namespace=10 AND tl_title='S'),
         CONCAT('# [[', page_title, ']] - ', page_len, ' (Stub)'), CONCAT('# [[', page_title, ']] - ', page_len) )
FROM page
WHERE page_namespace = 0 AND page_is_redirect = 0
AND page_len < 300
AND page_id NOT IN 
    (SELECT cl_from
    FROM categorylinks
    WHERE cl_to = 'Voci_protette'
    OR cl_to LIKE 'Da_trasferire%'
    OR cl_to = 'Voci_trasferite'
    OR cl_to LIKE 'Combinazioni_di%'
    OR cl_to LIKE 'Aiutare%'
    OR cl_to LIKE 'Liste_%'
    OR cl_to LIKE 'Decenni_%'
    OR cl_to LIKE 'Anni_%'
    OR cl_to LIKE 'Pagine_protette_per_minacce_legali'  )
AND page_id NOT IN 
    (SELECT pp_page
	FROM page_props
    WHERE pp_propname = 'disambiguation')
ORDER BY page_len, page_title;
