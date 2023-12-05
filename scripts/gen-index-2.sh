#!/bin/bash

rm -f index.html
touch index.html

sed -r 's/\"/ /g' apps-list-*.txt > loop.txt

echo "<!DOCTYPE html>
<html>
<head>
    <meta charset=utf-8>
	<title>P. Lombardo Shiny Apps</title>
	<link rel=stylesheet href=../css/styles.css>
</head>
<header> 
  <h1><i>Shiny Apps for Understanding Statistics</i></h1>
  <h2>" >> index.html
  echo "    $1</h2>
</header>
  <body>
    <p>Please select from the links below.</p>
" >> index.html



{
  read 
  while IFS=$'\t' read -r ID NAME DESC; do 
        echo "    <div class=\"myDIV\">" >> index.html
        # Will not run if no directories are available
        echo "      <a href=\"./$ID\">" >> index.html
        echo "          $NAME" >> index.html
        echo "        </a>" >> index.html
        echo "    </div>" >> index.html
        echo "    <div class=\"hide\">" >> index.html
        echo "      $DESC" >> index.html
        echo "    </div>" >> index.html  
  done
} < loop.txt

echo "  

  </body>
  <footer>
        Developed by P. Lombardo for the purpose of furthering statistics education.
  </footer>
</html>
" >> index.html