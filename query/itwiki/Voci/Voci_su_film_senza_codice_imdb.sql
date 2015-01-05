CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_id IN
(SELECT tl_from
FROM templatelinks
WHERE tl_title = 'Film')
AND page_id NOT IN
(SELECT tl_from
FROM templatelinks
WHERE tl_title = 'Imdb'
OR tl_title = 'IMDB'
OR tl_title = 'IMDb'
OR tl_title = 'Collegamenti_cinema')
ORDER BY page_title;
