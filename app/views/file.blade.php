@extends('layout')

@section('title')File - {{$data['file']}}@stop

@section('content')
    <h1>{{$data['title']}}</h1>

    <h2>
        Output ({{$data['results']}})
        <a href="{{str_replace('/lists/', '/lists/raw/', $_SERVER["REQUEST_URI"])}}">raw</a>
    </h2>
    <pre class="txt" style="font-family:monospace;">{{$data['output']}}</pre>

    <h2>Information</h2>
    Last run: {{$data['last_execution_at']}}<br />
    @if (array_key_exists('author',$data))
        Author: {{$data['author']}}<br />
    @endif
    @if (array_key_exists('license',$data))
        License: {{$data['license']}}<br />
    @endif
    @if (array_key_exists('frequency',$data))
        Frequency: {{$data['frequency']}}<br />
    @endif
    @if (array_key_exists('link',$data))
        Link: <a href="https://{{$data['project']}}/wiki/{{$data['link']}}" target="_blank">{{$data['link']}}</a><br />
    @endif
    @if ($data['run'] != 1)
        Query run {{$data['run']}} times taking averagely {{$data['runtime']}} seconds.<br />
    @else
        Query run {{$data['run']}} time taking {{$data['runtime']}} seconds.<br />
    @endif

    @if ($kind == 'mysql')
        <h2>Query</h2>
    @elseif
        <h2>Code</h2>
    @endif
    {{$data['query']}}

@stop
