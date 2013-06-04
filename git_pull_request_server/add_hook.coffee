## configs
USERNAME = 'Hi-king'
PASSWORD = 'password'


request = require('request')
# https://github.com/mikeal/request
querystring = require('querystring');
stream = require('stream')

params = {
        "name": "web",
        "active": true,
        "events": ["watch"],
        "config": {
                "url": "http://vps.hi-king.me:1337"
                "content_type": "form",
                "insecure_ssl": "1"
        }

        }
post_data = querystring.stringify(params)

post = request.post({
        uri: 'https://api.github.com/repos/Hi-king/test_hook/hooks',
        auth: {
                'user': USERNAME,
                'pass': PASSWORD
                },
        headers:{
                'Content-Length': JSON.stringify(params).length,
                'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'
        }}, (err, res, body) ->
                #console.log(err)
                #console.log(err.stack)
                console.log(body)
        )

jsonstream = new stream()
jsonstream.pipe = (dest) -> dest.write(JSON.stringify(params))
jsonstream.pipe(post)