@extends('layout')

@section('title')Documentation @stop

@section('content')
    <header>
        <h1>{{ Config::get('docs.title', 'Documentation') }}</h1>
    </header>
    <div class="row">
        <div class="col-md-3">
            {{ $index }}
        </div>
        <div class="col-md-9">
            {{ $chapter }}
            <nav>
            @if($prev)
                <a href="{{ $prev['URI'] }}" title="Previous: {{ $prev['title'] }}">← {{ $prev['title'] }}</a> |
            @endif
            @if($next)
                <a href="{{ $next['URI'] }}" title="Next: {{ $next['title'] }}">{{ $next['title'] }} →</a>
            @endif
            </nav>
        </div>
    </div>
    <div class="clearfix"></div>
@stop