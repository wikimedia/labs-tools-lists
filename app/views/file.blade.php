@extends('layout')

@section('title')File - {{$file}}@stop

@section('content')
    <h1>{{SourceController::linkedPath($path)}}</h1>

    <h2>Query</h2>
    <?php
	    $source = file_get_contents(base_path() . "/query/" . $file . ".sql");
    	$geshi = new GeSHi($source, 'sql');
    	echo $geshi->parse_code();
    ?>

    <h2>Output</h2>
@stop
