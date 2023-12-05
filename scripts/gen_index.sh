#!/bin/bash

rm -f links.txt
touch links.txt


for f in *; do
    if [ -d "$f" ]; then
        echo "    <div class=\"myDIV\">" >> links.txt
        # Will not run if no directories are available
        echo "      <a href=\"./$f\">" >> links.txt
        echo "          $f" | sed -r 's/-/ /g'  >> links.txt
        echo "        </a>" >> links.txt
        echo "    </div>" >> links.txt
        echo "    <div class=\"description\">" >> links.txt
        echo "      Here is my description" >> links.txt
        echo "    </div>" >> links.txt
    fi
done

echo "  </body>
</html>
" >> index.html