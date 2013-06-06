@extends('layout')

@section('title')Folder - {{$path}}@stop

@section('content')
    <h1>{{$path}}</h1>
    <?php
        if (strpos($path, "/")) {
            if(strpos($path, "/")) 
                $url = "/lists/" . substr($path, 0, strrpos($path, "/"));
            else
                $url = "/lists";
            echo "<a href=\"" . $url . "\">..</a><br />";
        }

        foreach (SourceController::getDir("query/" . $path) as $file)
        {
            if (strpos($file, "."))
                $url = "/lists/" . $path . "/" . substr($file, 0, strpos($file, "."));
            else
                $url = "/lists/" . $path . "/" . $file;
			echo "<a href=\"" . $url . "\">" . $file . "</a><br />";
        }
    ?>

@stop
