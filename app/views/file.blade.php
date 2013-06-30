@extends('layout')

@section('title')File - {{$file}}@stop

@section('content')
    <h1>{{$data['title']}}</h1>

    <h2>Output ({{$data['results']}})</h2>
    <pre class="txt" style="font-family:monospace;">{{data['output'])}}</pre>

    <h2>Information</h2>
    Last run: {{$data['last_execution_at']}}<br />
    @if ($data['author'])
        Author: {{$data['author']}}<br />
    @endif
    @if ($data['license'])
        License: {{$data['license']}}<br />
    @endif
    @if ($data['frequency'])
        Frequency: {{$data['frequency']}}<br />
    @endif
    @if ($db->times != 1)
        Query run {{$data['run']}} times taking averagely {{$data['runtime']}} seconds<br />
    @elseif
        Query run {{$data['run']}} time taking {{$data['runtime']}} seconds<br />
    @endif

    <h2>Query</h2>
    {{$data['query']}}

@stop
