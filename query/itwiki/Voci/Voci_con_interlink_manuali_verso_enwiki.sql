USE itwiki_p;
SELECT CONCAT("# [[", page_title, "]]")
FROM page
  WHERE page_namespace = 0
  AND page_id IN (SELECT iwl_from
    FROM iwlinks
	WHERE iwl_prefix IN ('en'))
  ORDER BY page_title;