// A collection of Gulp pipeline descriptions of how to manage the 
// browser artefacts.

var gulp = require('gulp');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');

gulp.task('minify-zepto', function() {
  return gulp.src([
    'zepto/src/zepto.js',
    'zepto/src/event.js',
    'zepto/src/ajax.js'
  ]).pipe(concat('zepto.min.js'))
  .pipe(uglify())
  .pipe(gulp.dest('../browser/vendor/zepto'));
});
 
gulp.task('minify-jasmine', function() {
  return gulp.src([
    'node_modules/jasmine-core/lib/jasmine-core/jasmine.js',
    'node_modules/jasmine-core/lib/jasmine-core/jasmine-html.js',
    'node_modules/jasmine-core/lib/jasmine-core/boot.js'
  ]).pipe(uglify())
    .pipe(gulp.dest('../specs/browser/vendor/jasmine'));
});

gulp.task('jasmine-artefacts', function() {
  return gulp.src([
    'node_modules/jasmine-core/images/jasmine_favicon.png',
    'node_modules/jasmine-core/lib/jasmine-core/jasmine.css'
  ]).pipe(gulp.dest('../specs/browser/vendor/jasmine'));
});

gulp.task('jasmine', ['minify-jasmine', 'jasmine-artefacts']);

gulp.task('default', ['jasmine', 'minify-zepto'], function() {
  // place code for your default task here
});
