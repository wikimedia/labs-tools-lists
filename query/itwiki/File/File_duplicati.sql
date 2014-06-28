CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[:File:", img1.img_name, "]] identica a [[:File:", img2.img_name, "]]" )
FROM image AS img1
JOIN image AS img2 ON img1.img_sha1 = img2.img_sha1
AND img1.img_name <> img2.img_name
WHERE img1.img_sha1 <> ''
AND img1.img_name NOT REGEXP 'Stub_.*'
AND img2.img_name NOT REGEXP 'Stub_.*'
GROUP BY img1.img_sha1
ORDER BY img1.img_name;
