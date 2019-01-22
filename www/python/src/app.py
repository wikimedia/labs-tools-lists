import os
import re
import configparser

from flask import Flask, Response, Markup
from flask import abort, render_template, redirect, url_for

from flaskext.markdown import Markdown

from pygments import highlight
from pygments.lexers.sql import MySqlLexer
from pygments.formatters import HtmlFormatter

app = Flask(__name__)
Markdown(app)

querydir = '/data/project/lists/query'
outputdir = '/data/project/lists/output'
docsdir = '/data/project/lists/docs'

project_links = {'itwiki': 'https://it.wikipedia.org/wiki/',
                 'itwikisource': 'https://it.wikisource.org/wiki/',
                 'wikidatawiki': 'https://www.wikidata.org/wiki/'}


def listdir(path):
    items = os.listdir(path)

    directories = []
    files = []

    for item in items:
        full_path = os.path.join(path, item)
        if os.path.isdir(full_path):
            directories.append(item)
        if os.path.isfile(full_path):
            if item[-3:] == 'out':
                files.append(item[:-4])

    return directories, files


def split_path(sub_path):
    result = {'full': sub_path,
              'split': []}
    abs_path = ''

    for s in sub_path.split('/'):
        if len(abs_path) > 0:
            abs_path += '/'
        abs_path += s
        if abs_path == sub_path:
            result['split'].append({'rel': s.replace("_", " ")})
        else:
            result['split'].append({'abs': abs_path,
                                    'rel': s.replace("_", " ")})

    return result


def resolve_ns(out_list):
    def ns_repl(match):
        ns_number = int(match.group(1))

        namespaces = {0: '',
                      1: 'Discussione:',
                      2: 'Utente:',
                      3: 'Discussioni_utente:',
                      4: 'Wikipedia:',
                      5: 'Discussioni_Wikipedia:',
                      6: ':File:',
                      7: 'Discussioni_file:',
                      8: 'MediaWiki:',
                      9: 'Discussioni_MediaWiki:',
                      10: 'Template:',
                      11: 'Discussioni_template:',
                      12: 'Aiuto:',
                      13: 'Discussioni_aiuto:',
                      14: ':Categoria:',
                      15: 'Discussioni_categoria:',
                      100: 'Portale:',
                      101: 'Discussioni_portale:',
                      102: 'Progetto:',
                      103: 'Discussioni_progetto:',
                      828: 'Modulo:',
                      829: 'Discussioni_modulo:'}

        try:
            ns_name = namespaces[ns_number]
        except KeyError:
            ns_name = ''

        return ns_name

    return re.sub(r'\{\{ns:([0-9]+)\}\}:', ns_repl, out_list)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html', projects=listdir(outputdir)[0]), 404


@app.route('/')
def home():
    return render_template('home.html', projects=listdir(outputdir)[0])


@app.route('/raw/<path:sub_path>')
def raw(sub_path):
    out_path = os.path.join(outputdir, sub_path + '.out')

    if os.path.isfile(out_path) == False:
        abort(404)

    with open(out_path, 'r', encoding='utf-8') as fp:
        out_list = fp.read()

    out_list = resolve_ns(out_list)

    return Response(out_list, mimetype='text/plain')


@app.route('/<path:sub_path>')
def show(sub_path):
    base_path = os.path.join(outputdir, sub_path)

    if os.path.isdir(base_path):
        directories, files = listdir(base_path)
        return render_template('directory.html', projects=listdir(outputdir)[0], sub_path=split_path(sub_path), directories=directories, files=files)

    out_path = base_path + '.out'
    run_path = base_path + '.run'
    sql_path = os.path.join(querydir, sub_path) + '.sql'
    cnf_path = sql_path[:-3] + 'cnf'

    if not os.path.isfile(out_path) or not os.path.isfile(run_path) or not os.path.isfile(sql_path) or not os.path.isfile(cnf_path):
        abort(404)

    with open(out_path, 'r', encoding='utf-8') as fp:
        out_list = fp.read()

    with open(sql_path, 'r', encoding='utf-8') as fp:
        sql_list = fp.read()

    run_file = configparser.ConfigParser()
    run_file.read(run_path)

    cnf_file = configparser.ConfigParser()
    cnf_file.read(cnf_path)

    info = {}

    info['lines'] = out_list.count('\n')

    try:
        info['last_run'] = run_file['output']['last_run']
        info['last_runtime'] = float(run_file['output']['last_runtime'])
        info['run_counter'] = int(run_file['output']['run_counter'])
        info['run_average'] = round(
            float(run_file['output']['total_runtime']) / info['run_counter'], 6)
        info['frequency'] = cnf_file['query']['frequency']
        info['project'] = project_links[cnf_file['query']['project']]
    except KeyError:
        abort(404)

    try:
        info['license'] = cnf_file['query']['license']
    except KeyError:
        info['license'] = None

    try:
        info['author'] = cnf_file['query']['author']
    except KeyError:
        info['author'] = None

    try:
        info['link'] = cnf_file['query']['link']
    except KeyError:
        info['link'] = None

    out_list = resolve_ns(out_list)
    out_list = Markup(re.sub(r'\[\[([^\]]*)\]\]', r'<a href="' +
                             info['project'] + r'\1" target="_blank">[[\1]]</a>', out_list))

    sql_list = Markup(highlight(sql_list, MySqlLexer(),
                                HtmlFormatter(nowrap=True, noclasses=True)))

    return render_template('file.html', projects=listdir(outputdir)[0], sub_path=split_path(sub_path), out_list=out_list, sql_list=sql_list, info=info)


@app.route('/docs')
@app.route('/docs/<section>')
def docs(section='introduction'):
    menu_path = os.path.join(docsdir, 'documentation.md')
    document_path = os.path.join(docsdir, section + '.md')

    if not os.path.isfile(menu_path) or not os.path.isfile(document_path):
        abort(404)

    with open(menu_path, 'r', encoding='utf-8') as fp:
        menu = fp.read()

    with open(document_path, 'r', encoding='utf-8') as fp:
        document = fp.read()

    return render_template('documentation.html', projects=listdir(outputdir)[0], menu=menu, document=document)
