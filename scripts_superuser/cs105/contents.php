<?php

//define the path as relative
$path = "./";

//using the opendir function
$dir_handle = @opendir($path) or die("Unable to open $path");

echo "Contents at this location:<br/><ul>";

//running the while loop
while ($file = readdir($dir_handle)) 
{
   if($file[0]!="." && !strstr($file, "php")) echo "<li><a href='$file'>$file</a></li><br/>";
}

//closing the directory
closedir($dir_handle);

echo "</ul>";
?> 
