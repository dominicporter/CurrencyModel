<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="../../favicon.ico">

  <title>Currency Model</title>

  <!-- Bootstrap core CSS -->
  <link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <!-- <link href="jumbotron.css" rel="stylesheet"> -->

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Currency Model</a>
    </div>
  </div>
</nav>

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
  <div class="container">
    <p>Enter names in the fields, then click "Submit" to submit the form:</p>

      <?php
      function saveVariable($filename, $default, $formVal){
        $fullFilename = "/var/".$filename;
        if (isset($formVal)) {
            $fp = fopen($fullFilename, 'w');
            fwrite($fp, $formVal);
            fclose($fp);
        }
        elseif ( ! file_exists($fullFilename) ) {
            $fp = fopen($fullFilename, 'w');
            fwrite($fp, $default);
            fclose($fp);
        }
      }

      saveVariable('numPeople.txt', 10, $_POST["numPeople"]);
      saveVariable('startingSum.txt', 1000, $_POST["startingSum"]);
      saveVariable('iterations.txt', 100, $_POST["iterations"]);
      saveVariable('transPerIter.txt', 80, $_POST["transPerIter"]);
      saveVariable('demurragePercent.txt', 1, $_POST["demurragePercent"]);
      saveVariable('transactPercent.txt', 10, $_POST["transactPercent"]);
      ?>

      <form id="frm1" action="index.php" method="post">
          <label for="numPeople">Number of People</label><input id ="numPeople" name="numPeople" type="text" value="<?php readfile("/var/numPeople.txt"); ?>"><br>
          <label for="startingSum">Starting sum </label><input id ="startingSum" name="startingSum" type="text" value="<?php readfile("/var/startingSum.txt"); ?>"><br>
          <label for="iterations">Number of Iterations</label><input id ="iterations" name="iterations" type="text" value="<?php readfile("/var/iterations.txt"); ?>"><br>
          <label for="transPerIter">Transactions per Iteration</label><input id ="transPerIter" name="transPerIter" type="text" value="<?php readfile("/var/transPerIter.txt"); ?>"><br>
          <label for="demurragePercent">Demurrage %</label><input id ="demurragePercent" name="demurragePercent" type="text" value="<?php readfile("/var/demurragePercent.txt"); ?>"><br>
          <label for="transactPercent">Transaction %</label><input id ="transactPercent" name="transactPercent" type="text" value="<?php readfile("/var/transactPercent.txt"); ?>"><br>
      <input type="submit" value="Submit">
    </form>

  </div>
</div>

<div class="container">
  <canvas id="myChart" width="1000" height="500" style="width:100%"></canvas>
  <div id="results"></div>
  <footer>
  </footer>
</div> <!-- /container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script src="vendor/Chart.js"></script>
<script src="temp/js/Account.js"></script>
<script src="temp/js/cm.js"></script>
<script>window.onload = window.CurrencyModel.myFunction();</script>
</body>
</html>
