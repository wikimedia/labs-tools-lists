<?php

/**
 * @author Fabio Alessandro Locati <fabiolocati@gmail.com>
 * @copyright Fabio Alessandro Locati 2013
 * @license AGPL-3.0 http://www.gnu.org/licenses/agpl-3.0.html
 */
class SourceController extends BaseController {

    /**
     * Generic function to show files or folder to the user
     * @param  string $path Path of the file/folder you want to show
     * @return View to show
     */
    public function show($path = null)
    {
        if (is_dir(base_path() . "/query/" . $path)) // Check if it's a folder
            return $this->showFolder($path);
        elseif (file_exists(base_path() . "/query/" . $path . ".cnf"))
            return $this->showFile($path);
        else
            App::abort(404);
    }

    /**
     * Generic function to show files to the user
     * @param  string $path Path of the file you want to show
     * @return View to show
     */
    public function showFile($path)
    {
        if (file_exists(base_path() . "/query/" . $path . ".sql"))
            return $this->showMysql($path);
        elseif (file_exists(base_path() . "/query/" . $path . ".py"))
            return $this->showPython($path);
        else
            App::abort(404);
    }

    /**
     * Function to show mysql query to the user
     * @param  string $path Meta-path of the file you want to show
     * @return View to show
     */
    public function showMysql($path)
    {
        // Retrive object from DB
        $db = Query::where('name', $path)->get()->first();

        // Get the Query source
        $source = file_get_contents(base_path() . "/query/" . $path . ".sql");
        $geshi = new GeSHi(trim($source), 'sql');

        // Get the output
        $filename = Execution::getSafeDate($db->last_execution_at) . ".out";
        $output = file_get_contents(base_path() . "/output/" . $path . "/" . $filename);

        // Get the config
        $config = parse_ini_file(base_path() . "/query/" . $path . ".cnf");

        // Get average run
        $runtime = DB::table('executions')->where('query_id', $db->id)->avg('duration');

        $data['file'] = $path;
        $data['title'] = SourceController::linkedPath($path);
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

        return View::make('file')->with('data', $data)->with('kind', 'mysql');
    }

    /**
     * Function to show python files to the user
     * @param  string $path Meta-path of the file you want to show
     * @return View to show
     */
    public function showPython($path)
    {
        // Retrive object from DB
        $db = Query::where('name', $path)->get()->first();

        // Get the Query source
        $source = file_get_contents(base_path() . "/query/" . $path . ".py");
        $geshi = new GeSHi(trim($source), 'python');

        // Get the output
        $filename = Execution::getSafeDate($db->last_execution_at) . ".out";
        $output = file_get_contents(base_path() . "/output/" . $path . "/" . $filename);

        // Get the config
        $config = parse_ini_file(base_path() . "/query/" . $path . ".cnf");

        // Get average run
        $runtime = DB::table('executions')->where('query_id', $db->id)->avg('duration');

        $data['file'] = $path;
        $data['title'] = SourceController::linkedPath($path);
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

        return View::make('file')->with('data', $data)->with('kind', 'python');
    }

    /**
     * Function to show folders to the user
     * @param  string $path Path of the folder you want to show
     * @return View to show
     */
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

    /**
     * Function to show the results of a query in a plain text format
     * @param  string $path Meta-path of the file you want to show
     * @return View to show
     */
    public function showRaw($path)
    {
        // Retrive object from DB
        if (!DB::table('queries')->where('name', $path)->count())
            App::abort(404);

        $db = Query::where('name', $path)->get()->first();
        $filename = Execution::getSafeDate($db->last_execution_at) . ".out";

        if (!file_exists(base_path() . "/output/" . $path . "/" . $filename))
            App::abort(404);

        echo file_get_contents(base_path() . "/output/" . $path . "/" . $filename);
    }

    /**
     * Function to show files to the user
     * @param  string $path Path of the file you want to show
     * @param array exts file extensions to show
     * @return View to show
     */
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

    /**
     * Create nicer pathname
     * @param  string $path Path that you want to nicefy
     * @return string       Nicefied path
     */
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

    /**
     * Improve the rendering of MediaWiki MarkDown
     * @param  string $code The code string
     * @param  string $prj  Extended project name (ie: en.wikipedia)
     * @return string       Improved MediaWiki code
     */
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
