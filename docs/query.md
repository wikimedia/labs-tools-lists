# Add query

- [The query](#the-query)
- [The config file](#the-config-file)

<a name="the-query"></a>
## The query

The query has to be a working MySQL/MariaDB query. Simply put it in a .sql file in the right subfolder of /query.

As first line you will have to add the following line:

	USE [PROJECT_SLUG]_p;

where **[PROJECT_SLUG]** will be the project codename (enwiki for Wikipedia in English, itwiki for Wikipedia in Italian, etc). For example, for Wikipedia in Italian:

	USE itwiki_p;

<a name="the-config-file"></a>
## The config file

For each query, a config file is needed. The config file will have to be:

- in the same folder of the query;
- called with the same name;
- have the **.cnf** extension.

The structure of the file is:

	[query]
	project = itwiki
	frequency = default
	author = unknown
	license = CC-BY-SA
	link = WP:EGO/E

The **project** field has to be the same as **[PROJECT_SLUG]** from before.

The **frequency** field will be used to run the query. Actual valid values are:

- default (currently means daily)
- daily
- twiceweekly
- weekly
- twicemonthly
- monthly

The **author** field asks for the author name. If the query is taken from the wiki itself and is difficult or impossible to determine the author, set to `unknown` or avoid putting this field.

The **license** field asks for the query license. If the query is taken from the wiki itself the license will be `CC-BY-SA`. Suggested values are:

- CC-BY-SA
- CC-0
- GPL-3.0
- **AGPL-3.0** (preferred)
- MIT

The **link** field asks for the page title of the corresponding list on Wikipedia. This field is optional.
