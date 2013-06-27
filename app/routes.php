<?php

Route::get('/', function() {return View::make('home');});
Route::get('docs/{chapter?}', 'DocumentationController@showDocs');
Route::get('{path?}', array('uses' => 'SourceController@show'))->where('path', '.*');