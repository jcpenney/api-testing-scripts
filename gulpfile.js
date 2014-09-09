/*******************************************************************/
/* Imports */
/*******************************************************************/

var Gulp = require('gulp');

var Clean = require('gulp-clean');
var Coffee = require('gulp-coffee');
var FS = require('fs-extra');
var Plumber = require('gulp-plumber');
var Uglify = require('gulp-uglify');


/*******************************************************************/
/* Paths */
/*******************************************************************/

var paths = {}

paths.build = {
  dir: './build'
}

paths.scripts = {
  src: ['./src/**/*.coffee'],
  dest: paths.build.dir
};

/*******************************************************************/
/* Tasks */
/*******************************************************************/

// Clean the build directory
Gulp.task('clean-build', function() {
  FS.removeSync(paths.build.dir);
});

// Compile and uglify all coffeescript files
Gulp.task('scripts', function() {
  
});

// Rerun the task when a file changes
Gulp.task('watch', function () {
  Gulp.watch(paths.scripts.src, ['scripts']);
});

// The default task (called when you run `gulp` from cli)
Gulp.task('default', ['clean-build', 'build', 'watch']);
Gulp.task('clean', ['clean-build']);
Gulp.task('build', ['scripts'])