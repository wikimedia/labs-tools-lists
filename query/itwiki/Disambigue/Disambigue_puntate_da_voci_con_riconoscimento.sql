CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']] (', COUNT(*), ')')
FROM page, pagelinks
WHERE pl_title = page_title
AND page_namespace = 0
AND page_is_redirect = 0
AND pl_namespace = 0
AND page_id IN
(SELECT pp_page
  FROM page_props
  WHERE pp_propname = 'disambiguation')
  AND pl_from IN
  (SELECT page_id
    FROM page, templatelinks, categorylinks
    WHERE page_namespace = 0
    AND page_id = tl_from
    AND page_id = cl_from
    AND (cl_to LIKE 'Voci_di_qualità_valutate_nel_mese_di%'
      OR cl_to LIKE 'Voci_entrate_in_vetrina_nel_mese_di%' )
      AND ( tl_title = 'Voce_di_qualità'
        OR tl_title = 'Vdq'
        OR tl_title = 'VdQ'
        OR tl_title = 'Vetrina' ))
        GROUP BY page_title
        ORDER BY COUNT(*) DESC, page_title;
