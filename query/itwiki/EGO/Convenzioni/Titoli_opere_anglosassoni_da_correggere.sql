CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]") 
  FROM page 
  WHERE page_namespace = 0 
  AND page_title REGEXP '.*_(A|An|The|And|But|Nor|Or|As|At|By|For|From|In|Of|On|Over|To|With)_.*'
