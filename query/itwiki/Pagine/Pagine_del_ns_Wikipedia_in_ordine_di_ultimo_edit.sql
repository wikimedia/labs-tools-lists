SELECT CONCAT('# [[Wikipedia:', page_title, ']], (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
  FROM page JOIN revision ON page_latest=rev_id
  WHERE page_namespace=4 AND page_is_redirect=0
    AND page_title NOT LIKE '%/%'
  ORDER BY rev_timestamp ASC
  LIMIT 5000;
