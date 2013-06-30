@extends('layout')

@section('title')Folder - {{$data['path']}}@stop

@section('content')
    <h1>{{$data['title']}}</h1>

    @foreach($data['list'] as $listElement)
        {{$listElement}}<br />
    @endforeach
@stop
