USE itwiki_p;
SELECT CONCAT ("* [[:File:", img_name, "]]")
  FROM image 
  WHERE img_name REGEXP "^[0-9]{1,4}px-.*";
