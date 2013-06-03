express = require('express')

app = express()
app.use(express.bodyParser())

# post
app.post('/', (req, res) ->
        console.log(req.body)
        )

# start
app.listen(1337)