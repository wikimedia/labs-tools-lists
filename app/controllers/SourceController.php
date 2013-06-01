<?php

class SourceController extends BaseController {

    public static function listFolder($path)
    {
        $dir = "../query/" . $path;
        $files = scandir($dir);
        $out = "";
        foreach ($files as $file)
        {
            switch ($file) {
                case '.':
                    break;
                case '..':
                    if ($path != "")
                        if(strpos($path, "/"))
                            $out .= "<a href=\"" . substr($path, 0, strrpos($path, "/")) . "\">" . $file . "</a><br />";
                        else
                            $out .= "<a href=\"/lists/src\">" . $file . "</a><br />";
                    break;
                default:
                    if (strpos($file, "."))
                        $out .= "<a href=\"" . $path . "/" . substr($file, 0, strpos($file, ".")) . "\">" . $file . "</a><br />";
                    else
                        $out .= "<a href=\"/lists/src/" . $path . "/" . $file . "\">" . $file . "</a><br />";
                    break;
            }
        }
        return $out;
    }

    public function show($path = null)
    {
        if(is_dir("../query/" . $path)) // Check if it's a folder
            echo SourceController::listFolder($path);
        else
        {
            return View::make('file')
                ->with('file', $path);
        }
    }

}
