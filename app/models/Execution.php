<?php

/**
 * @author Fabio Alessandro Locati <fabiolocati@gmail.com>
 * @copyright Fabio Alessandro Locati 2013
 * @license AGPL-3.0 http://www.gnu.org/licenses/agpl-3.0.html
 */
class Execution extends Eloquent{

	/**
	 * Fillable elements
	 * @var array
	 */
	protected $fillable = array('query_id', 'time', 'duration', 'results');

	/**
	 * Timestamps on database
	 * @var boolean
	 */
	public $timestamps = false;

	/**
	 * Transform standard date to FileSystem-safe date
	 * @param  string $date The date to transform
	 * @return string       Transformed date
	 */
	public static function getSafeDate($date)
	{
		return date('Ymd-His', strtotime($date));
	}

}