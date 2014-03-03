CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("* [[:File:", itwiki_p.image.img_name, "|]] (", itwiki_p.image.img_size,
       "; su [[:commons:File:", itwiki_p.image.img_name, "|commons]]: ", 
       commonswiki_f_p.image.img_size, ")")
FROM image
LEFT JOIN commonswiki_f_p.image
WHERE commonswiki_f_p.image.img_name = itwiki_p.image.img_name
ORDER BY itwiki_p.image.img_name;
