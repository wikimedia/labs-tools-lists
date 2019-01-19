#!/usr/bin/env python2
"""
Queries the Wikimedia projects database replica on labsdb to list all active
users speaking a certain language, in a format usable by MassMessage.
Do not use the targets blindly! Check they make sense, remove bots if needed.

Usage:
    userslang --help
    userslang <language> [--editcount=<N>] [--top=<N>]

Options:
    --help           Prints this documentation
    <language>       The language code to look for.
    --editcount=<N>  Minimum edits in last 6 months. 0 to disable [default: 1000].
    --top=<N>        Users to list from the top of most active [default: 0].

Copyright waived (CC-0), Federico Leva, 2015
"""
import docopt
import MySQLdb
import re
#https://github.com/PyMySQL/PyMySQL/issues/339
#import pymysql
#import pymysql.cursors

__version__ = "0.0.1"

def main(argv=None):
    args = docopt.docopt(__doc__, argv=argv)

    run(args['<language>'], int(args['--editcount']), int(args['--top']))

def run(language, editcount, top):
    printedusers = set([])

    print("Searching for users active in language %s" % language)
    wikis = get_wikis(language)
    print("Got %d wikis to check for this language" % len(wikis))

    for wiki in wikis:
        print("Searching %s" % wiki[1])
        langsearch = language
        # User preferences are not recorded if they are default.
        if langsearch == wiki[2]:
            print("This wiki's language is %s, will list everyone" % wiki[2])
            langsearch = None
        activeusers = set(get_active_users(wiki[0], editcount, langsearch))
        topusers = set(get_top_users(wiki[0], top, langsearch))
        for name in activeusers | topusers:
            if name[0] not in printedusers:
                domain = re.sub("http://", "", wiki[1])
                print("* {{target | user = %s | site = %s }}" % (name[0], domain))
                printedusers.add(name[0])

def get_wikis(language):
    """ List of wikis in list format: dbname, url. """

    wikis = """SELECT dbname, url, lang
FROM meta_p.wiki AS w
WHERE w.is_closed = 0
AND ( w.lang = "%s"
OR w.family = "special" )""" % language

    connection = MySQLdb.connect(host='metawiki.labsdb',
                                 db="meta_p",
                                 read_default_file='~/.my.cnf')
    cursor = connection.cursor()
    cursor.execute(wikis)
    return cursor.fetchall()

def get_active_users(wiki, edits, language=None):
    """ List of usernames with the language and more than the given edits in 6 months. """

    if edits == 0:
        return []

    users = """SELECT distinct(user_name)
FROM user u %s
WHERE u.user_editcount > %d
AND (SELECT SUM(contribs)
     FROM user_daily_contribs udc
     WHERE udc.user_id = u.user_id
     AND day > NOW() - INTERVAL 6 MONTH ) > %d""" % (language_join(language), edits*2, edits)

    connection = MySQLdb.connect(host=wiki + '.labsdb',
                                 db=wiki + '_p',
                                 read_default_file='~/.my.cnf')
    cursor = connection.cursor()
    cursor.execute(users)
    return cursor.fetchall()

def get_top_users(wiki, top, language=None):
    """ List of top active usernames with the language ordered by total edits. """

    if top == 0:
        return []

    users = """SELECT distinct(user_name)
FROM user u %s
WHERE u.user_editcount > 30
AND (SELECT SUM(contribs)
     FROM user_daily_contribs udc
     WHERE udc.user_id = u.user_id
     AND day > NOW() - INTERVAL 6 MONTH ) > 30
ORDER BY u.user_editcount DESC
LIMIT %d""" % (language_join(language), top)

    connection = MySQLdb.connect(host=wiki + '.labsdb',
                                 db=wiki + '_p',
                                 read_default_file='~/.my.cnf')
    cursor = connection.cursor()
    cursor.execute(users)
    return cursor.fetchall()

def language_join(language=None):
    """ Look for user preferences if needed. """

    if language is None:
        return ""

    return """\nJOIN user_properties up
ON u.user_id = up.up_user
AND up.up_property = 'language'
AND up.up_value = '%s'""" % language

if __name__ == "__main__":
    main()
