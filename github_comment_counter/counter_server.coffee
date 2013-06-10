## configs::global
OWNER = 'Hi-king'
REPONAME = 'test_hook'
BASEURL = 'https://api.github.com'
USERS = ['Hi-king', 'foobar']
## configs::secret
USERNAME = 'your-user-name'
PASSWORD = 'your-password'


request = require('request')
sync = require('sync')
# https://github.com/mikeal/request

###########
# globals #
###########
counts = {}

#################
# main function #
#################
pull_req_counter = (pull_req_counter_callback) ->
    request.get(
        {
        uri: BASEURL + '/repos/'+OWNER+'/'+REPONAME+'/pulls',
        auth: {
                'user': USERNAME,
                'pass': PASSWORD
                },
        headers:{
                'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'
                }
        },
        (err, res, body) ->
            ## init ##
            #counts = {}
            #for user in USERS
            #    counts[user] = 0
                
            #console.log(err)

            ## each pull requests ##
            waits = []
            for pull_req in JSON.parse(body)
                #console.log(pull_req)
                #console.log(pull_req.review_comments_url)
                console.log(pull_req._links.review_comments.href)
                #console.log(pull_req.comments_url)

                ## get comments
                commentcounter = (callback) ->
                    request.get(
                        {uri: pull_req._links.review_comments.href,
                        auth: {'user': USERNAME, 'pass': PASSWORD}
                        headers: {'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'}
                        },
                        (err, res, body) ->
                            for comment in JSON.parse(body)
                                console.log(comment)
                                counts[comment.user.login] += 1
                            callback()
                    )
                waits.push(commentcounter)
            ## sync ##
            waitlen = waits.length;
            for func in waits
                func(() ->
                    if(waitlen--)
                        pull_req_counter_callback()
                        console.log(counts)
                    )

        )


################
## web server ##
################
app = require('express')()
ejs = require('ejs')
fs = require('fs')
template = fs.readFileSync('./template.ejs', 'utf8')


app.get(
    '/',
    (req, res) ->
        for user in USERS
            counts[user]=0
        pull_req_counter(() ->
            res.writeHead(200, {'Content-Type': 'text/html'})
            res.write( ejs.render(template, {'counts': counts}) )
            res.end()
            #res.send(counts)
        )
    
    )
app.listen(1234)