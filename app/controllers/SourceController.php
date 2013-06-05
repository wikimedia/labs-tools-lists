<?php

class SourceController extends BaseController {

    public function show($path = null)
    {
        if(is_dir(base_path() . "/query/" . $path)) // Check if it's a folder
            return View::make('folder')->with('path', $path);
        else
        {
            return View::make('file')->with('file', $path);
        }
    }

    public static function getDir($path)
    {
    	$elements = scandir(base_path() . "/" . $path);
  		unset($elements[0]);
  		unset($elements[1]);
  		return $elements;
    }
}
