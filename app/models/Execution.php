<?php

class Execution extends Eloquent{

	protected $fillable = array('query_id', 'time', 'duration', 'results');
	public $timestamps = false;

	public static function getSafeDate($date)
	{
		return date('Ymd-His', strtotime($date));
	}

}