import os
import logging
import subprocess
import configparser

from datetime import datetime, timedelta, timezone

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


def process_list(cnf_path):
    # Create the paths
    sql_path = cnf_path[:-3] + 'sql'
    run_path = cnf_path.replace(querydir, outputdir, 1)[:-3] + 'run'
    tmp_path = run_path[:-3] + 'tmp'
    out_path = run_path[:-3] + 'out'

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
        logging.exception('Invalid configuration in %s', cnf_path)
        return

    try:
        delta = deltas[frequency]
    except KeyError:
        logging.exception('Invalid frequency in %s', cnf_path)
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
        logging.info('No need to run %s', cnf_path)
        return

    # Execute the query
    logging.info('Executing %s', cnf_path)
    start_datetime = datetime.utcnow()

    try:
        subprocess.run('mysql --defaults-file=~/replica.my.cnf -h ' + project +
                       '.analytics.db.svc.eqiad.wmflabs -BN < ' + sql_path + ' > ' + tmp_path, shell=True, check=True)
        os.replace(tmp_path, out_path)
    except subprocess.CalledProcessError:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)
        logging.exception('Subprocess error for %s', cnf_path)
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
