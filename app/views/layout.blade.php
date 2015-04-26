<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Lists Project - @yield('title')</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="//tools-static.wmflabs.org/static/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
      body {
        padding-top: 50px;
      }
      a:visited {
        color: #2a6496;
      }
    </style>
	<script src="//tools-static.wmflabs.org/static/jquery/2.1.0/jquery.min.js"></script>
    <script src="//tools-static.wmflabs.org/static/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/lists">Lists</a>
        </div>
        <div class="collapse navbar-collapse">
          <p class="navbar-text pull-right">
            <a href="/lists/docs" class="navbar-link">Docs</a>
          </p>
          <ul class="nav navbar-nav">
            @foreach (SourceController::getDir("query") as $file)
              <li><a href="/lists/{{$file}}">{{$file}}</a></li>
            @endforeach
          </ul>
        </div>
      </div>
    </div>

    <div class="container">
      @yield('content')
    </div> <!-- /container -->

  </body>
</html>
