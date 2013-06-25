<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class SyncCrontab extends Command {

	/**
	 * The console command name.
	 *
	 * @var string
	 */
	protected $name = 'crontab:sync';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Sync db with cnf file';

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
		$directory = base_path() . "/query/";
		$it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($directory));
		$files = array();
		while($it->valid()) {
		    if (!$it->isDot() AND preg_match("/.*\.cnf/i", $it->getSubPathName()))
		        $files[] = substr($it->getSubPathName(), 0, -4);
		    $it->next();
		}

		foreach ($files as $file) {
			$filepath = base_path() . "/query/" . $file;
			$query = file_get_contents($filepath . ".sql");
			$config = parse_ini_file($filepath . ".cnf");
			if (!Query::where('name', $file)->count())
				$obj = Query::create(array('name' => $file, 'frequency' => $config['frequency']));
			else
				if (Query::find($id)->pluck('frequency') != $config['frequency'])
					Query::find($id)->update(array('frequency' => $config['frequency']));
		}
	}

	/**
	 * Get the console command arguments.
	 *
	 * @return array
	 */
	protected function getArguments()
	{
		return array();
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