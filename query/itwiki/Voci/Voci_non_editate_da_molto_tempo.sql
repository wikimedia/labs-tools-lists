SELECT CONCAT('* [[', page_title, ']], (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
  FROM page JOIN revision ON page_latest=rev_id
  WHERE page_namespace=0 AND page_is_redirect=0
    AND page_id NOT IN (SELECT tl_from 
      FROM templatelinks 
      WHERE tl_namespace=10 AND tl_title IN ('Disambigua', 'Sigla2', 'Sigla3') )
  ORDER BY rev_timestamp ASC
  LIMIT 7500;
