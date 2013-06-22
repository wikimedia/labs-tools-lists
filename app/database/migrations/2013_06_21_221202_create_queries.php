<?php

use Illuminate\Database\Migrations\Migration;

class CreateQueries extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('queries', function($table)
		{
    		$table->increments('id');
    		$table->string('name');
    		$table->timestamp('last_execution_at');
    		$table->integer('times');
    		$table->timestamps();
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('queries');
	}

}