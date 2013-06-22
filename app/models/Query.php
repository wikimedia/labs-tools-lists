<?php

class Query extends Eloquent{

	protected $table = 'queries';

	protected $fillable = array('name', 'last_execution_at');

}