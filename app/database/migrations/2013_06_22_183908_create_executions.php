<?php

use Illuminate\Database\Migrations\Migration;

class CreateExecutions extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('executions', function($table)
		{
    		$table->increments('id');
    		$table->integer('query_id')->unsigned();
    		$table->timestamp('time');
    		$table->time('duration');
    		$table->integer('results');
    		$table->foreign('query_id')->references('id')->on('queries');
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('executions');
	}

}