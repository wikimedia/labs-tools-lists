<?php

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

/**
 * @author Fabio Alessandro Locati <fabiolocati@gmail.com>
 * @copyright Fabio Alessandro Locati 2013
 * @license AGPL-3.0 http://www.gnu.org/licenses/agpl-3.0.html
 */
class TwiceMonthlyCrontab extends Command {

	/**
	 * The console command name.
	 */
	protected $name = 'crontab:twicemonthly';

	/**
	 * The console command description.
	 */
	protected $description = 'Twicemonthly crontab of the project';

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
		shell_exec('php ' . base_path() . '/artisan crontab:sync');
		$queries = Query::where('frequency', 'twicemonthly')->get();
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
