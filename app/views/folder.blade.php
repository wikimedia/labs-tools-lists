@extends('layout')

@section('title')Folder - {{$path}}@stop

@section('content')
    <h1>{{SourceController::linkedPath($path)}}</h1>
    <?php

        foreach (SourceController::getDir("query/" . $path, array('sql')) as $file)
        {
            if (strpos($file, ".")) {
                $url = "/lists/" . $path . "/" . substr($file, 0, strpos($file, "."));
                $label = str_replace('_', ' ', substr($file, 0, strpos($file, ".")));
            } else {
                $url = "/lists/" . $path . "/" . $file;
                $label = str_replace('_', ' ', $file);
            }
			echo "<a href=\"" . $url . "\">" . $label . "</a><br />";
        }
    ?>

@stop
