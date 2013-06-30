<?php

Route::get('/', function() {return View::make('home');});
Route::get('docs/{chapter?}', 'DocumentationController@showDocs');
Route::get('raw/{path?}', 'SourceController@showRaw')->where('path', '.*');
Route::get('{path?}', 'SourceController@show')->where('path', '.*');