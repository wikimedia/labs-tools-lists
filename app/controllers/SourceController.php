<?php

class SourceController extends BaseController {

    public function show($path = null)
    {
        if(is_dir(base_path() . "/query/" . $path)) // Check if it's a folder
            return View::make('folder')->with('path', $path);
        else
        {
            return $this->showFile($path, $path);
        }
    }

    public function showFile($file)
    {
        // Retrive object from DB
        $db = Query::where('name', $file)->get()->first();

        // Get the Query source
        $source = file_get_contents(base_path() . "/query/" . $file . ".sql");
        $geshi = new GeSHi(trim($source), 'sql');

        // Get the output
        $filename = Execution::getSafeDate($db->last_execution_at) . ".out";
        $output = file_get_contents(base_path() . "/output/" . $file . "/" . $filename);

        // Get the config
        $config = parse_ini_file(base_path() . "/query/" . $file . ".cnf");

        // Get average run
        $runtime = DB::table('executions')->where('query_id', $db->id)->avg('duration');

        $data['file'] = $file;
        $data['title'] = SourceController::linkedPath($file);
        $data['results'] = $db->last_execution_results;
        $data['output'] = SourceController::cleanWikiCode(trim($output),$config['project']);
        $data['last_execution_at'] = $db->last_execution_at;
        if ($config['author'] AND $config['author'] != 'unknown')
            $data['author'] = $config['author'];
        if ($config['license'])
            $data['license'] = $config['license'];
        if ($config['frequency'])
            if ($config['frequency'] == 'default')
                $data['frequency'] = 'daily';
            else
                $data['frequency'] = $config['frequency'];
        $data['run'] = $db->times;
        $data['runtime'] = round($runtime / 1000, 3);
        $data['query'] = $geshi->parse_code();

        return View::make('file')->with('data', $data);
    }

    public function showFolder($path)
    {
        $data['path'] = $path;
        $data['title'] = SourceController::linkedPath($path);
        foreach (SourceController::getDir("query/" . $path, array('sql')) as $file)
        {
            if (strpos($file, ".")) {
                $url = "/lists/" . $path . "/" . substr($file, 0, strpos($file, "."));
                $label = str_replace('_', ' ', substr($file, 0, strpos($file, ".")));
            } else {
                $url = "/lists/" . $path . "/" . $file;
                $label = str_replace('_', ' ', $file);
            }
            $data['list'][] = "<a href=\"" . $url . "\">" . $label . "</a>";
        }
        return View::make('folder')->with('data', $data);
    }

    public static function getDir($path, $exts = null)
    {
        if (!is_dir(base_path() . "/" . $path))
            return array();
    	$elements = scandir(base_path() . "/" . $path);
  		unset($elements[0]);
  		unset($elements[1]);
        if (!is_array($exts))
      		return array_values($elements);
        else {
            if (sizeof($exts) == 1)
                $rule = "/.*\." . implode('|', $exts) ."/i";
            else
                $rule = "/.*\.[" . implode('|', $exts) ."]/i";
            $out = array();
            foreach ($elements as $element) {
                if (preg_match($rule, $element) OR is_dir(base_path() . "/" . $path . "/" . $element))
                    $out[] = $element;
            }
        return $out;
        }
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
                $cv = str_replace('_', ' ', $v);
	    		$out .= "<a href=\"" . $url . "\">" . $cv . "</a>/";
    			$last = $url;
    		}
    	}

    	$out .= str_replace('_', ' ', $array[$lastElementKey]);
    	return $out;
    }

    public static function cleanWikiCode($code, $prj)
    {
        $replace = '<a href="http://' . Config::get('project.' . $prj) . '/wiki/${1}">[[${0}]]</a>';
        $code = preg_replace('/\[\[(.*)\]\]/i', $replace, $code);
        $code = preg_replace_callback('/\[\[(.*)\]\]/i', function ($matches) {
            return str_replace('_', ' ', $matches[1]);
        }, $code);
        return $code;
    }
}
