SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_id IN
(SELECT il_from
FROM imagelinks
WHERE il_to <> 'Disambigua_compass.svg'
AND il_to <> 'Wiktionary_small.svg'
AND il_to <> 'Nuvola_mimetypes_charnotfound.PNG')
AND page_id IN 
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')