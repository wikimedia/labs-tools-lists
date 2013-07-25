<?php

/**
 * @author Fabio Alessandro Locati <fabiolocati@gmail.com>
 * @copyright Fabio Alessandro Locati 2013
 * @license AGPL-3.0 http://www.gnu.org/licenses/agpl-3.0.html
 */
class Query extends Eloquent{

	/**
	 * Specify table name
	 * @var string
	 */
	protected $table = 'queries';

	/**
	 * Fillable elements
	 * @var array
	 */
	protected $fillable = array('name', 'frequency', 'last_execution_at', 'last_execution_results');

}