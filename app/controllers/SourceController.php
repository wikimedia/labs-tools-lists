<?php

class SourceController extends BaseController {

    public function show($path = null)
    {
        if(is_dir(base_path() . "/query/" . $path)) // Check if it's a folder
            return View::make('folder')->with('path', $path);
        else
        {
            return View::make('file')
            	->with('file', $path)
            	->with('path', $path);
        }
    }

    public static function getDir($path)
    {
    	$elements = scandir(base_path() . "/" . $path);
  		unset($elements[0]);
  		unset($elements[1]);
  		return $elements;
    }

    public static function linkedPath($path)
    {
    	$array = explode("/", $path);
    	$out = "";
    	$last = "/lists";
    	$lastElementKey = sizeof($array) - 1;

    	foreach ($array as $k => $v) {
    		if ($k < $lastElementKey) {
    			$url = $last . "/" . $v;
	    		$out .= "<a href=\"" . $url . "\">" . $v . "</a>/";
    			$last = $url;
    		}
    	}

    	$out .= $array[$lastElementKey];
    	return $out;

    }
}
