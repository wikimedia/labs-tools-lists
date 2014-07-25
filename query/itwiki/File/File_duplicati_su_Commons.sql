CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[:File:", img1.img_name, "]] identica a [[:commons:File:", img2.img_name, "]]" )
FROM image AS img1
JOIN commonswiki_p.image AS img2 ON img1.img_sha1 = img2.img_sha1
WHERE img1.img_sha1 <> ''
AND img1.img_name NOT REGEXP 'Stub_.*\.png'
AND img1.img_name NOT REGEXP '.*-Stemma\.png'
AND img1.img_name NOT IN (
SELECT page_title
FROM categorylinks, page
WHERE cl_from = page_id
AND (cl_to = 'PD_Italia'
OR cl_to = 'Screenshot_film_PD-Italia'
OR cl_to = 'Immagini_con_PD_Italia_trasferibili'
OR cl_to = 'Immagini_con_PD_Italia_trasferite')
AND cl_type = 'file')
GROUP BY img1.img_sha1
ORDER BY img1.img_name;
