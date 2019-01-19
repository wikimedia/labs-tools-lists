USE itwiki_p;
SELECT CONCAT( "# [[:File:", img1.img_name, "]] - [[:commons:File:", img2.img_name, "]]" )
FROM image AS img1
JOIN commonswiki_p.image AS img2 ON img1.img_name = img2.img_name;