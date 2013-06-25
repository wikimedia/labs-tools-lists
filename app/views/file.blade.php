@extends('layout')

@section('title')File - {{$file}}@stop

@section('content')
    <?php
        $object = Query::where('name', $path)->get()->first();
    ?>
    <h1>{{SourceController::linkedPath($path)}}</h1>

    <h2>Query</h2>
    <?php
	    $source = file_get_contents(base_path() . "/query/" . $file . ".sql");
    	$geshi = new GeSHi(trim($source), 'sql');
    	echo $geshi->parse_code();
    ?>

    <h2>Output ({{$object->last_execution_results}})</h2>
    <?php
    	$filename = Execution::getSafeDate($object->last_execution_at) . ".out";
    ?>
    <pre class="sql" style="font-family:monospace;">{{SourceController::cleanWikiCode(trim($source))}}</pre>

@stop
