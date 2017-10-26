
# Build processes using [Gulp](http://gulpjs.com)

Load Gulp modules.

    gulp = require 'gulp' # main tool
    coffee = require 'gulp-coffee' # compile coffeescript
    uglify = require 'gulp-uglify' # minify javascript
    sourcemaps = require 'gulp-sourcemaps' # create source maps
    pump = require 'pump' # good error handling of gulp pipes

The only build task in this simple repository to compiles the one source
file, with minification and source maps.

    gulp.task 'default', -> pump [
        gulp.src 'lwp-example-simple.litcoffee'
        sourcemaps.init()
        coffee bare : yes
        uglify()
        sourcemaps.write '.'
        gulp.dest '.'
    ]
