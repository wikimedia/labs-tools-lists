# Add query

- [The query](#the-query)
- [The config file](#the-config-file)

<a name="the-query"></a>
## The query

The query has to be a working MySQL/MariaDB query. Simply put it in a .sql file in the right subfolder of /query.

As first line you will have to add the following line:

	CONNECT [PROJECT_SLUG]_p [PROJECT_SLUG].labsdb;

where **[PROJECT_SLUG]** will be the project codename: (enwiki for wikipedia in English, itwiki for Wikipedia in Italian, etc). Ie for Wikipedia in Italian:

	CONNECT itwiki_p itwiki.labsdb;

<a name="the-config-file"></a>
## The config file

Foreach query, a config file is needed. The config file will have to be:

- in the same folder of the query
- called with the same name
- have the **.cnf** extention

The structure of the file is:

	[query]
	project = itwiki
	frequency = default
	author = unknown
	license = CC-BY-SA

The **project** field have to be the same as **[PROJECT_SLUG]** from before.

The **frequency** field will be used to run the query. Actual valid values are:

- default (currently means daily)
- daily
- weekly
- none (the query will never be run)

The **author** field asks for author name. If the query is taken from the wiki itself and is difficult or impossible to determine the author, set to `unknown`.

The **license** field asks for the query license. If the query is taken from the wiki itself the licene will be `CC-BY-SA`. Actual valid values are:

- CC-BY-SA
- CC-0
- GPL-3.0
- **AGPL-3.0** (prefered)
- MIT
