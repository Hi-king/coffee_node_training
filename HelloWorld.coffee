#program = require 'commander'
#program.parse process.argv
#console.log program.args

# == hello world ==
console.log "Hello World"

# == fizz buzz ==
for i in [1..10]
    console.log(i)
    if i%15 is 0
        console.log "fizzbuzz"
    else if i%3 is 0
        console.log "fizz"
    else if i%5 is 0
        console.log "buzz"

# == currying ==
add = (x, y) -> x+y
console.log add(2,3)
add = (x) -> (y) -> x+y
console.log add(2)(3)
add2 = add(2)
console.log add2(3)