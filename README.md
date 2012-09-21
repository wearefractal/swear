![status](https://secure.travis-ci.org/wearefractal/swear.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>swear</td>
</tr>
<tr>
<td>Description</td>
<td>Under 1K so its hot</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
<tr>
<td>Size (minified)</td>
<td>1008 bytes</td>
</tr>
<tr>
<td>Size (gzipped)</td>
<td>452 bytes</td>
</tr>
</table>

## Usage

```coffee-script
p = swear()

# success
# resolve can take variable arguments
p.when (data) -> console.log "Done! #{data}"
p.resolve "test"

# failure
p.fail (err) -> console.log "Task failed! #{err}"
p.abort new Error "something died"

# sugar for node
# p.wrap returns a function that will abort if the first arg exist or pass the rest of the args to resolve
fs.readFileSync "test.txt", p.wrap()

# join returns a new promise from as many promises as you want
p2 = swear()
newp = swear.join p, p2

newp.when -> console.log "p and p2 done"
newp.fail (err) -> console.log "p or p2 failed with #{err}"

# aborting a promise will fail abort promise it was joined into
p.abort "some error" # this will fail newp
```

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
