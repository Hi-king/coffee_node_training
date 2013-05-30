feedparser = require('feedparser')

URL = "http://www.twitter-rss.com/user_timeline.php?screen_name=Hi_king"


titleprinter = (x, y) ->
    for item in y
        console.log(item.title)

feedparser.parseFile(URL).on('complete', titleprinter)

