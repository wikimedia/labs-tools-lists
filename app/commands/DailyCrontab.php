<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

/**
 * @author Fabio Alessandro Locati <fabiolocati@gmail.com>
 * @copyright AGPL-3.0
 */
class DailyCrontab extends Command {

	/**
	 * The console command name.
	 */
	protected $name = 'crontab:daily';

	/**
	 * The console command description.
	 */
	protected $description = 'Daily crontab of the project';

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
		$queries = Query::where('frequency', 'daily')->get();
		foreach ($queries as $query) {
			shell_exec('php ' . base_path() . '/artisan crontab:exec ' . $query['name']);
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