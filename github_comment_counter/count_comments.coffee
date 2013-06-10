## configs::global
OWNER = 'Hi-king'
REPONAME = 'test_hook'
BASEURL = 'https://api.github.com'
USERS = ['Hi-king', 'Keisuke-Ogaki']
## configs::secret
USERNAME = ''
PASSWORD = ''


request = require('request')
# https://github.com/mikeal/request

#################
# main function #
#################
pull_req_counter = () ->
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
            counts = {}
            for user in USERS
                counts[user] = 0
                
            #console.log(err)

            ## each pull requests ##
            waits = []
            for pull_req in JSON.parse(body)
                #console.log(pull_req)
                #console.log(pull_req.review_comments_url)
                console.log(pull_req._links.review_comments.href)
                #console.log(pull_req.comments_url)

                ## get comments
                commentcounter = () ->
                    request.get(
                        {uri: pull_req._links.review_comments.href,
                        auth: {'user': USERNAME, 'pass': PASSWORD}
                        headers: {'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'}
                        },
                        (err, res, body) ->
                            for comment in JSON.parse(body)
                                console.log(comment)
                                counts[comment.user.login] += 1
                    )
                waits.push(commentcounter)
            wait(waits)
            console.log(counts)
        )


################
## web server ##
################
pull_req_counter()