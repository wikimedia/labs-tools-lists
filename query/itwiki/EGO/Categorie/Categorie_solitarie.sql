CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT( "# [[:Categoria:", nome, "]]")
	FROM (
    	SELECT cl_to AS nome, count( * ) AS numero
    		FROM categorylinks
    		GROUP BY cl_to
 	) AS categorie
 	WHERE numero = 1
 	ORDER BY numero, nome
	LIMIT 7500;
