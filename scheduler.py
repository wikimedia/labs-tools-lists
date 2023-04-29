import configparser
import logging
import os
from datetime import datetime, timedelta

import pymysql

querydir = '/data/project/lists/query'
outputdir = '/data/project/lists/output'

logging.basicConfig(filename='scheduler.log', level=logging.INFO,
                    format='%(asctime)s %(levelname)s %(message)s')

deltas = {'default': timedelta(days=1),
          'daily': timedelta(days=1),
          'weekly': timedelta(weeks=1),
          'monthly': timedelta(weeks=4),
          'twiceweekly': timedelta(days=3, hours=12),
          'twicemonthly': timedelta(weeks=2)}


def tuple_to_string(result):
    string = ""
    for row in result:
        if len(row) == 1:
            value = row[0]
            if isinstance(value, bytes):
                value = value.decode('utf-8')
            string += str(value) if value is not None else "NULL"
            string += "\n"
        else:
            row_list = []
            for value in row:
                if isinstance(value, bytes):
                    value = value.decode('utf-8')
                row_list.append(str(value) if value is not None else "NULL")
            string += "\t".join(row_list) + "\n"
    return string


def run_query(input_file, output_file, project):
    with open(input_file, "r") as f:
        query = f.read()
    
    db = pymysql.connect(
        read_default_file="~/replica.my.cnf",        
        host=project + ".analytics.db.svc.eqiad.wmflabs",
        database=project + "_p"
    )
    
    cursor = db.cursor()
    cursor.execute(query)
    
    results = cursor.fetchall()
    
    db.close()
    
    with open(output_file, "w") as f:
        for result in results:
            f.write(tuple_to_string(result))


def process_list(cnf_path):
    # Create the paths
    sql_path = cnf_path[:-3] + 'sql'
    run_path = cnf_path.replace(querydir, outputdir, 1)[:-3] + 'run'
    tmp_path = run_path[:-3] + 'tmp'
    out_path = run_path[:-3] + 'out'
    list_path = cnf_path.replace(querydir, '')[1:-4]

    # Create the output directory
    if not os.path.exists(os.path.dirname(run_path)):
        os.makedirs(os.path.dirname(run_path))

    # Read the configuration file
    cnf_file = configparser.ConfigParser()
    cnf_file.read(cnf_path)

    try:
        project = cnf_file['query']['project']
        frequency = cnf_file['query']['frequency']
    except KeyError:
        logging.exception('Invalid configuration in %s', list_path)
        return

    if frequency == 'none':
        logging.info('Skipping %s', list_path)
        return

    try:
        delta = deltas[frequency]
    except KeyError:
        logging.exception('Invalid frequency in %s', list_path)
        return

    # Read the run file
    run_file = configparser.ConfigParser()
    run_file.read(run_path)

    try:
        last_run = datetime.strptime(
            run_file['output']['last_run'], '%Y-%m-%d %H:%M:%S.%f')
        run_counter = int(run_file['output']['run_counter'])
        total_runtime = float(run_file['output']['total_runtime'])
    except (KeyError, ValueError):
        run_file['output'] = {}
        last_run = datetime.strptime(
            '1970-01-01 00:00:00.000000', '%Y-%m-%d %H:%M:%S.%f')
        run_counter = 0
        total_runtime = 0.0

    # Check if we need to run the query
    if datetime.utcnow() < last_run + delta:
        logging.info('No need to run %s', list_path)
        return

    # Execute the query
    logging.info('Executing %s', list_path)
    start_datetime = datetime.utcnow()

    try:
        run_query(sql_path, tmp_path, project)
        os.replace(tmp_path, out_path)
    except:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)
        logging.exception('MySQL error for %s', list_path)
        return

    end_datetime = datetime.utcnow()
    runtime = (end_datetime - start_datetime).total_seconds()

    # Write run file
    run_file['output']['last_run'] = str(end_datetime)
    run_file['output']['last_runtime'] = str(runtime)
    run_file['output']['run_counter'] = str(run_counter + 1)
    run_file['output']['total_runtime'] = str(
        round(total_runtime + runtime, 6))

    with open(run_path, 'w', encoding='utf-8') as fp:
        run_file.write(fp)


if __name__ == '__main__':
    logging.info('Scheduler task has started')

    # For all the configuration files
    for root, subdirs, files in os.walk(querydir):
        for file_name in files:
            if file_name[-3:] == 'cnf':
                process_list(os.path.join(root, file_name))

    logging.info('Scheduler task has ended')
