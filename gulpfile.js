/*******************************************************************/
/* Imports */
/*******************************************************************/

var gulp = require('gulp');

var clean = require('gulp-clean');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var gulpif = require('gulp-if');
var plumber = require('gulp-plumber');
var uglify = require('gulp-uglify');
var util = require('gulp-util');


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
gulp.task('clean-build', function() {
  return gulp.src(paths.build.dir, { read: false })
    .pipe(plumber())
    .pipe(clean());
});

// Compile, uglify, and concatenate all coffeescript/javascript files
gulp.task('scripts', function() {
  return gulp.src(paths.scripts.src)
    .pipe(plumber())
    .pipe(gulpif(/[.]coffee$/, coffee()))
    // .pipe(uglify({ mangle: false }))
    .pipe(gulp.dest(paths.scripts.dest));
});

// Rerun the task when a file changes
gulp.task('watch', function () {
  gulp.watch(paths.scripts.src, ['scripts']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['clean-build', 'build', 'watch']);
gulp.task('clean', ['clean-build']);
gulp.task('build', ['scripts'])