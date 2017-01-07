CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "#[[:File:", img1.img_name, "|]] identica a [[:commons:File:", img2.img_name, "|]]" )
FROM image AS img1
JOIN commonswiki_p.image AS img2 ON img1.img_sha1 = img2.img_sha1
WHERE img1.img_sha1 <> ''
AND img1.img_name NOT REGEXP 'Stub_.*\.png'
AND img1.img_name NOT REGEXP '.*-Stemma\.png'
GROUP BY img1.img_sha1
ORDER BY img1.img_name;
