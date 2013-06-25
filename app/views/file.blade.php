@extends('layout')

@section('title')File - {{$file}}@stop

@section('content')
    <?php
        // Retrive object from DB
        $db = Query::where('name', $path)->get()->first();

        // Get the Query source
        $source = file_get_contents(base_path() . "/query/" . $file . ".sql");
        $geshi = new GeSHi(trim($source), 'sql');

        // Get the output
        $filename = Execution::getSafeDate($db->last_execution_at) . ".out";
        $output = file_get_contents(base_path() . "/output/" . $file . "/" . $filename);

        // Get the config
        $config = parse_ini_file(base_path() . "/query/" . $file . ".cnf");
    ?>
    <h1>{{SourceController::linkedPath($path)}}</h1>

    <h2>Output ({{$db->last_execution_results}})</h2>
    <pre class="txt" style="font-family:monospace;">{{SourceController::cleanWikiCode(trim($source),$config['project'])}}</pre>

    <h2>Information</h2>
    Last run: {{$db->last_execution_at}}<br />

    <h2>Query</h2>
    {{$geshi->parse_code()}}

@stop
