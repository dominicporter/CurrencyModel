module.exports = (grunt) ->

#    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt)

#    // Time how long tasks take
    require('time-grunt')(grunt)

#    // Project configuration.
    grunt.initConfig(

        pkg: grunt.file.readJSON('package.json')

        clean:
            dev: ['temp']
            dist: ['dist']


        watch:
            options:
                livereload: true

            files:[
                'temp/js/*.js'
                'coffee/*.coffee'
                'temp/test/js/**/*.js'
                'test/coffee/**/*.coffee'
                '*.html'
            ]

            tasks: [
                'dev'
            ]

        connect:
            options:
                port: 8080
                hostname: 'localhost'
                open: true

            server:
                options:
                    keepalive: true

            livereload:
                options:
                    livereload: true

        coffee:
            src:
                expand: true
                flatten: true
                cwd: 'coffee'
                src: ['*.coffee']
                dest: 'temp/js'
                ext: '.js'
            test:
                expand: true
                flatten: true
                cwd: 'test/coffee'
                src: ['**/*.coffee']
                dest: 'temp/test/js'
                ext: '.js'

        jasmine:
            all:
                options:
                    specs: [
                        'temp/test/js/**/*Spec.js'
                        'test/Jasmine2-teamcityreporter.js'
                    ]
                    vendor: 'vendor/*.js'
                    keepRunner: true

                src: 'js/**/*.js'
    )

    grunt.registerTask('dev', [
        'clean:dev', 'coffee', 'jasmine:all:build'
    ])

    grunt.registerTask('server', [
        'dev', 'connect:server'
    ])

    grunt.registerTask('livereload', [
        'dev', 'connect:livereload', 'watch'
    ])

    grunt.registerTask('test', [
        'clean:dev', 'coffee', 'jasmine:all'
    ])

    grunt.registerTask('default', [
        'dev'
    ])