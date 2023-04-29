SELECT CONCAT("# [[:File:", img_name, "]]")
FROM image
WHERE img_name NOT IN (
	SELECT page_title
	FROM page
	WHERE page_namespace LIKE 6)
  ORDER BY img_name;
