<?php

class SourceController extends BaseController {

    public function show($path = null)
    {
        if(is_dir("../query/" . $path)) // Check if it's a folder
            return View::make('folder')->with('path', $path);
        else
        {
            return View::make('file')->with('file', $path);
        }
    }

}
