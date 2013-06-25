<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class ExecCrontab extends Command {

	/**
	 * The console command name.
	 *
	 * @var string
	 */
	protected $name = 'crontab:exec';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Perform a crontabbed query';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		parent::__construct();
	}

	/**
	 * Execute the console command.
	 *
	 * @return void
	 */
	public function fire()
	{
		$file = $this->argument('query');
		$filepath = base_path() . "/query/" . $file;
		$query = file_get_contents($filepath . ".sql");
		$config = parse_ini_file($filepath . ".cnf");
		if (is_object(Query::find($config['id'])))
			$db = Query::find($config['id'])->get();
		else {
			$this->error('Query not present in db');
			return 1;
		}
		if (!is_dir(base_path() . "/output/" . $file))
			if (!mkdir(base_path() . "/output/" . $file, 0777, TRUE)) {
				$this->error('Impossible to create the output folder');
				return 1;
			}
		$date = date('Y-m-d H:i:s');
		$outpath = base_path() . "/output/" . $file . "/" . Execution::getSafeDate($date);
		$c = "mysql --defaults-file=~/replica.my.cnf -h {$config['project']}.labsdb";
		$c.= "< {$filepath}.sql > {$outpath}.out";
		$time = -microtime();
		$output = shell_exec($c);
		$time += microtime();
		$lines = shell_exec('wc -l {$outpath}.out');
		Execution::create(array('query_id' => $config['id'], 'time' => $date, 'duration' => $time, 'results' => $lines));
	}

	/**
	 * Get the console command arguments.
	 *
	 * @return array
	 */
	protected function getArguments()
	{
		return array(
			array('query', InputArgument::REQUIRED, 'Query full path'),
		);
	}

	/**
	 * Get the console command options.
	 *
	 * @return array
	 */
	protected function getOptions()
	{
		return array();
	}

}