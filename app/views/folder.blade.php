@extends('layout')

@section('title')File - {{$path}}@stop

@section('content')
    <h1>{{$path}}</h1>
    <?php
	    $dir = base_path() . "/query/" . $path;
        $files = scandir($dir);
        $out = "";
        if ($path != "")
            if(strpos($path, "/"))
                $out .= "<a href=\"" . substr($path, 0, strrpos($path, "/")) . "\">..</a><br />";
            else
                $out .= "<a href=\"/lists/src\">..</a><br />";
        foreach ($files as $file)
        {
            if ($file != "." AND $file != "..") {
                if (strpos($file, "."))
                    $out .= "<a href=\"" . $path . "/" . substr($file, 0, strpos($file, ".")) . "\">" . $file . "</a><br />";
                else
                    $out .= "<a href=\"/lists/src/" . $path . "/" . $file . "\">" . $file . "</a><br />";
                break;
            }
        }
        echo $out;
    ?>

@stop
