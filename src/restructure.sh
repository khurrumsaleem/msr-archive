# cp ../docs/msrepublications.md ./msrepublications.md
cp ../docs/msrepublications.md reports.tmp
cp ../docs/msrepublications.md articles.tmp

# collect tabels
vim -c ":norm Go" -c ":g/###/norm 4jd}Gp" -c ":wq" reports.tmp
vim -c ":norm Go" -c ":g/**Papers Relating to /norm 4jd}Gp" -c ":wq" articles.tmp

# remove everything but collected tabels
vim -c ":1,602d" -c ":wq" reports.tmp
vim -c ":1,1520d" -c ":wq" articles.tmp

# change occurances of e.g. 'Lastname, F. M.' to 'F. M. Lastname'
vim -c "%s/| \(\w\+\), \(\S\+\) |/| \2 \1 |/g" -c ":wq" reports.tmp
vim -c "%s/| \(\w\+\), \(\S\+\) \(\S\+\) |/| \2 \3 \1 |/g" -c ":wq" reports.tmp

vim -c "%s/| \(\w\+\), \(\S\+\) <br>/| \2 \1 <br>/g" -c ":wq" reports.tmp
vim -c "%s/| \(\w\+\), \(\S\+\) \(\S\+\) <br>/| \2 \3 \1 <br>/g" -c ":wq" reports.tmp

vim -c "%s/<br> \(\w\+\), \(\S\+\) <br>/<br> \2 \1 <br>/g" -c ":wq" reports.tmp
vim -c "%s/<br> \(\w\+\), \(\S\+\) \(\S\+\) <br>/<br> \2 \3 \1 <br>/g" -c ":wq" reports.tmp

vim -c "%s/<br> \(\w\+\), \(\S\+\) |/<br> \2 \1 |/g" -c ":wq" reports.tmp
vim -c "%s/<br> \(\w\+\), \(\S\+\) \(\S\+\) |/<br> \2 \3 \1 |/g" -c ":wq" reports.tmp


vim -c "%s/| \(\w\+\), \(\S\+\) |/| \2 \1 |/g" -c ":wq" articles.tmp
vim -c "%s/| \(\w\+\), \(\S\+\) \(\S\+\) |/| \2 \3 \1 |/g" -c ":wq" articles.tmp

vim -c "%s/| \(\w\+\), \(\S\+\) <br>/| \2 \1 <br>/g" -c ":wq" articles.tmp
vim -c "%s/| \(\w\+\), \(\S\+\) \(\S\+\) <br>/| \2 \3 \1 <br>/g" -c ":wq" articles.tmp

vim -c "%s/<br> \(\w\+\), \(\S\+\) <br>/<br> \2 \1 <br>/g" -c ":wq" articles.tmp
vim -c "%s/<br> \(\w\+\), \(\S\+\) \(\S\+\) <br>/<br> \2 \3 \1 <br>/g" -c ":wq" articles.tmp

vim -c "%s/<br> \(\w\+\), \(\S\+\) |/<br> \2 \1 |/g" -c ":wq" articles.tmp
vim -c "%s/<br> \(\w\+\), \(\S\+\) \(\S\+\) |/<br> \2 \3 \1 |/g" -c ":wq" articles.tmp

# seperate article title and publication
vim -c ':%s/",/" |' -c ":wq" articles.tmp

# sort based on first column
tail -n +1 reports.tmp  | sort --field-separator=\| --key=2 > reports.md
tail -n +1 articles.tmp | sort --field-separator=\| --key=2 > articles.md


cat /dev/null > publications.md

vim -c ":norm i| Document Number | Date | Author | Title |
|:--|:--|:--|:--|" -c ":wq" publications.md

cat reports.md >> publications.md

vim -c ":norm Go
| Author | Title | Publication |
|:--|:--|:--|" -c ":wq" publications.md

cat articles.md >> publications.md


rm reports.tmp articles.tmp reports.md articles.md
