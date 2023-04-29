SELECT CONCAT( "# ", nome, " (", numero, ")")
FROM (
SELECT el_to AS nome, count( * ) AS numero
FROM externallinks
GROUP BY el_to
) AS link
WHERE numero >= 100
AND nome NOT REGEXP ".*wiki(pedia|media)\.org.*"
ORDER BY numero DESC;
