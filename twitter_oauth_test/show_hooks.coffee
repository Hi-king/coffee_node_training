# http://d.hatena.ne.jp/sugyan/20110105/1294157289
oauth = new (require('oauth')).OAuth(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/access_token',
    'J0tcTlTSZBmhejTeDUpLg', # consumer key
    'SpeRCTbHZvjER9enCHhUaUhbz1rWdjZbHHS4ri7bo', # consumer secret
    '1.0',
    'http://localhost:1234', # callback URL
    'HMAC-SHA1'
)

oauth_token = ""
oauth_token_secret = ""
access_token = ""
access_token_secret = ""

## Get request token
oauth.getOAuthRequestToken(
    (err, now_oauth_token, now_oauth_token_secret, results) ->
        console.log(err)
        console.log(results)
        oauth_token = now_oauth_token
        oauth_token_secret = now_oauth_token_secret
        ## show auth url
        console.log('https://api.twitter.com/oauth/authorize?oauth_token=' + oauth_token)
)


## wait for redirect
server = require('express')()
server.listen(1234)

server.get(
    '/'
    (req, res) ->
        res.writeHead(200, {'Content-Type': 'text/html'})
        res.end()
        oauth.getOAuthAccessToken(
            oauth_token,
            null,
            req.query.oauth_verifier,
            (err, now_oauth_access_token, now_oauth_access_token_secret, results) ->
                access_token = now_oauth_access_token
                access_token_secret = now_oauth_access_token_secret
                console.log(err)
                console.log(results)
                twittertest()
        )
)            

twittertest = () ->
    oauth.get(
        "https://api.twitter.com/1/statuses/user_timeline.json"
        access_token,
        access_token_secret,
        (err, data) ->
            data = eval(data)
            for datum in data
                console.log(datum['text'])
            console.log(err)
    )
