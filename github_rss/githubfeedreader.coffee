feedparser = require('feedparser')
URL = "https://github.com/Hi-king.atom"

OWNER = "Hi-king"
REPONAME = "test_hook"


# titleprinter = (x, y) ->
#     for item in y
#         if(item.title.match("comment.*pull.*"+OWNER+"/"+REPONAME))
#             console.log(item.title)
#             console.log(item)

# feedparser.parseFile(URL).on('complete', titleprinter)


commentCounter = (username, owner, reponame, callback) ->
    baseurl = "https://github.com/"
    url = baseurl+username+".atom"
    console.log(URL)
    console.log(url)
    count = 0

    feedparser.parseFile(url)
    .on(
        'complete',
        (header, articles)->
            for article in articles
                console.log(article.title)
                if(article.title.match("comment.*pull.*"+owner+"/"+reponame))
                    count+=1
                    console.log(article.title)
            console.log("count="+count)
            #ans.push([username, count])
            #console.log(ans)
            
            callback(username, count)
    )
        
ans =[]    
ansManager = (username, count) ->
    ans.push([username, count])
    console.log(ans)

commentCounter("Hi-king", OWNER, REPONAME, ansManager)
commentCounter("Hi-king", OWNER, REPONAME, ansManager)
