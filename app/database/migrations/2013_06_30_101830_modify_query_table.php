<?php

use Illuminate\Database\Migrations\Migration;

class ModifyQueryTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('queries', function($table)
		{
			$table->string('kind');
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('queries', function($table)
		{
			$table->dropColumn('kind');
		});
	}

}