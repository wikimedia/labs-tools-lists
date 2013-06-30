@extends('layout')

@section('title')File - {{$data['file']}}@stop

@section('content')
    <h1>{{$data['title']}}</h1>

    <h2>Output ({{$data['results']}})</h2>
    <pre class="txt" style="font-family:monospace;">{{$data['output']}}</pre>

    <h2>Information</h2>
    Last run: {{$data['last_execution_at']}}<br />
    @if (array_key_exists('author',$data))
        Author: {{$data['author']}}<br />
    @endif
    @if (array_key_exists('license',$data))
        License: {{$data['license']}}<br />
    @endif
    @if (array_key_exists('frequency',$data)
        Frequency: {{$data['frequency']}}<br />
    @endif
    @if ($data['run'] != 1)
        Query run {{$data['run']}} times taking averagely {{$data['runtime']}} seconds<br />
    @elseif
        Query run {{$data['run']}} time taking {{$data['runtime']}} seconds<br />
    @endif

    <h2>Query</h2>
    {{$data['query']}}

@stop
