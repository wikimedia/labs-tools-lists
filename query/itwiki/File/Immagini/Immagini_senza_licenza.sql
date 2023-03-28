USE itwiki_p;
SELECT CONCAT('# [[:File:', page_title, ']]') as filename
FROM page
WHERE page_namespace = 6
  AND page_is_redirect = 0
  AND page_id NOT IN (
    SELECT cl_from
    FROM categorylinks
    WHERE cl_to = 'Autorizzate_per_Wikipedia'
       OR cl_to LIKE 'Copertine_d%'
       OR cl_to LIKE 'Copyright%'
       OR cl_to = 'Crown_copyright'
       OR cl_to = 'FAL'
       OR cl_to = 'Immagini_BSD'
       OR cl_to LIKE 'Immagini_Creative_Commons%'
       OR cl_to = 'Immagini_ESA'
       OR cl_to LIKE 'Immagini_GFDL%'
       OR cl_to = 'Immagini_GPL'
       OR cl_to = 'Immagini_MIT'
       OR cl_to = 'Immagini_NATO'
       OR cl_to LIKE 'Immagini_con_PD_Italia%'
       OR cl_to = 'Immagini_con_autorizzazione_VRTS'
       OR cl_to LIKE 'Immagini_con_licenza%'
       OR cl_to = 'Immagini_con_marchi_registrati'
       OR cl_to = 'Immagini dal sito del Parlamento Europeo'
       OR cl_to = 'Immagini_di_Donkey_Kong'
       OR cl_to = 'Immagini_di_Due_fantagenitori'
       OR cl_to = 'Immagini_di_Mario'
       OR cl_to = 'Immagini_di_Wario'
       OR cl_to = 'Immagini_di_Yoshi'
       OR cl_to = 'Immagini_di_euro'
       OR cl_to = 'Immagini_di_paesi_non_firmatari_della_convenzione_di_Berna'
       OR cl_to = 'Immagini_di_pubblico_dominio'
       OR cl_to LIKE 'Immagini_fairuse%'
       OR cl_to = 'Immagini_in_CC_BY-SA'
       OR cl_to = 'Immagini_libere'
       OR cl_to = 'Immagini_logo_di_partiti_politici_autorizzate_per_Wikipedia'
       OR cl_to = 'Immagini_non_commerciali'
       OR cl_to = 'Immagini_non_libere'
       OR cl_to LIKE 'Immagini_protette%'
       OR cl_to LIKE 'Immagini_stemmi%'
       OR cl_to = 'LGPL'
       OR cl_to LIKE 'Marchi%'
       OR cl_to LIKE 'Opere_protette_da%'
       OR cl_to LIKE 'PD%'
       OR cl_to = 'PoloniaGov'
       OR cl_to LIKE 'Screenshot%'
       OR cl_to LIKE 'Stemmi%'
)
ORDER BY page_title;
