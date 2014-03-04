CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT ("* [[:File:", img_name, "]]")
  FROM image 
  WHERE img_name REGEXP "^[0-9]{1,4}px-.*";
