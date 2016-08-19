module.exports = function(grunt) {

    grunt.initConfig({
        pkg         : grunt.file.readJSON('package.json'),
        watch       : {
            files: ['Gruntfile.js'],
            tasks: ['bower_concat', 'uglify']
        },
        bower_concat: {
            all: {
                dest        : 'src/main/resources/javascript/lib/_ffct.js',
                cssDest     : 'src/main/resources/css/lib/_ffct.css',
                exclude     : [
                    'angular',
                    'angular-animate'
                ],
                bowerOptions: {
                    relative: false
                }
            }
        },
        uglify: {
            options: {
                mangle: false,
                compress: false,
                beautify:true
            },
            my_target: {
                files: {
                    'src/main/resources/javascript/lib/_ffct.min.js': ['src/main/resources/javascript/lib/_ffct.js']
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-bower-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.registerTask('default', ['bower_concat', 'uglify']);

};
