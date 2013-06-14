@extends('layout')

@section('title')File - {{$file}}@stop

@section('content')
    <h1>{{SourceController::linkedPath($path)}}</h1>

    <h2>Query</h2>
    <?php
	    $source = file_get_contents(base_path() . "/query/" . $file . ".sql");
    	$geshi = new GeSHi(trim($source), 'sql');
    	echo $geshi->parse_code();
    ?>

    <h2>Output</h2>
    <?php
    	$outputs = SourceController::getDir("output/" . $path);
    	$filename = $outputs[sizeof($outputs) - 1];
    	
	    $source = file_get_contents(base_path() . "/output/" . $file . "/" . $filename);
    	$geshi = new GeSHi(trim($source), 'sql');
    	echo $geshi->parse_code();
    ?>

@stop
