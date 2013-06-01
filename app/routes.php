<?php

Route::get('/', function() {return View::make('home');});
Route::get('{path?}', array('uses' => 'SourceController@show'))->where('path', '.*');
