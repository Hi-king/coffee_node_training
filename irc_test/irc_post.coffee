# https://node-irc.readthedocs.org/en/latest/index.html
irc = require('irc')

config = {
    channels: ["#test"],
	server: "127.0.0.1",
	botName: "hikingbot"
}

bot = new irc.Client(config.server, config.botName, {debug: true, channels: ['#test']})

bot.on('join#test', (nick, message) ->
    bot.say("#test", "hello")
)
    
# bot.addListener(
#     "message",
#     (from, to, text, message) ->
#     	bot.say(from, "hello");
# )