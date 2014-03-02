CONNECT itwiki_p itwiki.labsdb commonswiki_p commonswiki.labsdb;
SELECT "# [[:File:", commonswiki.image.img_name, "|]] (su [[:commons:Image:",
       commonswiki.image.img_name, "|commons]]): ", commonswiki.image.img_size
FROM commonswiki.image
JOIN itwiki.image
WHERE commonswiki.image.img_name = itwiki.image.img_name
ORDER BY commonswiki.image.img_size DESC ;
