## configs
USERNAME = 'Hi-king'
PASSWORD = 'password'


request = require('request')
# https://github.com/mikeal/request

request.get({
        uri: 'https://api.github.com/repos/Hi-king/test_hook/hooks',
        auth: {
                'user': USERNAME,
                'pass': PASSWORD
                },
        headers:{
                'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'
        }}, (err, res, body) ->
                console.log(body)
        )