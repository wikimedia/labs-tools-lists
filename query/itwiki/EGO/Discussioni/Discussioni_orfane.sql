CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', nstalk.ns_name, ':', disc.page_title, ']] ([[Speciale:PuntanoQui/', nstalk.ns_name, ':', disc.page_title, '|Link]] - [[Special:Undelete/', nspage.ns_name, ':', disc.page_title, '|pagina]] - ', disc.page_len, ' byte)')
  FROM page as disc
  JOIN p50380g50614__lists.ns_it AS nstalk ON disc.page_namespace = nstalk.ns_id
  JOIN p50380g50614__lists.ns_it AS nspage ON (disc.page_namespace - 1) = nspage.ns_id
  WHERE disc.page_namespace in (1,5,7,9,11,13,15,101,103)
    AND disc.page_title NOT LIKE '%/da_fare'
    AND disc.page_title NOT REGEXP './[Aa]rchiv.'
    AND NOT EXISTS (
      SELECT *
      FROM page
      WHERE page_title = disc.page_title
			AND page_namespace = disc.page_namespace - 1)
  ORDER BY nstalk.ns_name, disc.page_title;
