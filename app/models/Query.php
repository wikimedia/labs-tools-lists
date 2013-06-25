<?php

class Query extends Eloquent{

	protected $table = 'queries';

	protected $fillable = array('name', 'frequency', 'last_execution_at', 'last_execution_results');

}