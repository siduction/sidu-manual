<div id="main-page"></div>
<div class="divider" id="search-on"></div>
## On-Line Searching

#### Option 1

Type in one or more words into the search field and click `Search (or press Return)` .


---

<form method="get" action="/cgi-bin/perlfect/search-en/search.pl">
  
<input type="hidden" name="p" value="1" />  
<input type="hidden" name="lang" value="en" />  
<input type="hidden" name="include" value="" />  
<input type="hidden" name="exclude" value="" />  
<input type="hidden" name="penalty" value="0" />  
<select name="mode">  
<option value="all">Match ALL words</option>  
<option value="any">Match ANY word</option>  
</select>  
<input type="text" name="q" /><input type="submit" value="Search" />  


</form>

---

###### Searching options

If `Match ALL words`  is selected, only those documents are returned which contain all of your search terms. With `Match ANY word`  all documents are returned which contain at least one of your search terms. 

Alternatively you can put a `plus (+) sign`  directly in front of one or more words to only get those files which include all of those words. Words with a `minus (-) sign`  directly in front of them change the result so that only documents are listed which don't contain any of those words.

Note that phrase searches are not supported, i.e. it doesn't make sense to put quotes around your query `"like this"` .

The results are ordered by relevance with the most relevant documents listed first. Relevance depends on the number and position of matched words in the documents. 

#### Option 2

To search on line, type or paste into the search box of your browser the following, (where `xxxx`  is the word you wish to search for):

~~~  
xxxxx site:manual.siduction.org/en  
~~~

<div class="divider" id="search-off"></div>
## Off-line Searching

Trevor Walkley (bluewater) has created some special configs in conjunction with the Developer for Recoll as a part of the default package. Recoll is a personal full text search tool for Unix/Linux. It is based on the very strong Xapian back-end, for which it provides a feature-rich yet easy to use front-end with a QT graphical interface.  *A very special thank you to Recoll* .

Recoll is called `Personal Search Tool`  in the Debian Menu of KDE.

##### Step 1

The manual is currently available via apt for the following languages: de, en, pt-br.

~~~  
apt-get update  
apt-get install bluewater-manual-xx (where -xx is your language)  
~~~

##### Step 2

~~~  
apt-get install recoll  
~~~

##### Step 3

+ Recoll on the first start will ask you if you want to build the database, `click cancel` , where upon an indexing configuration box will appear.  
+ In the Global parameters - Top directories box, click on the `+ (plus)`  sign and go to `/usr/share/bluewater-manual`  and click on your language and click ok. Next click on the `- (minus)`  sign and delete any other folders including `~ (tilde)` .  
+ Finally `File>Update Index`  and search the topic you need in the siduction-manual.  

If you need to reset the index in Recoll due to the bluewater-manual updating via apt, `(as user $ in konsole)` :

~~~  
recollindex -z  
~~~

Then in Recoll: `File>Update Index` .

The 'Preview' link will highlight all instances of your search word in the file, whereas 'Open' will open Konqueror, and use the `Find on this page`  command for a micro search for the word you searched in Recoll.

 [The Home page of Recoll](http://www.lesbonscomptes.com/recoll/) .

<div id="rev">Content last revised 13/01/2012 1200 UTC</div>
