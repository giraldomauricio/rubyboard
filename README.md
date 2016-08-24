# RubyBoard
Simple Database-less Kanban board made in JRuby and Sinatra.

_Rubyboard_ is a basic Kanban board to manage tasks using multiple swim
lines and steps or states.

Just create a new tasks and move them across the columns just using drag and drop. Each task will
be stored as a YML file and the interactions are recorded in a log file. The log
file can be digested to obtain valuable information about the process of 
your project.

Some features are:

1. Database independent. No need to setup any additional infrastructure.
2. File system based. You practically can move the steps using the `mv` command.
3. Extensible. There is no limit of swim lines, states or information per task.
4. Based on Standards. Bootstrap and JQuery. No extra components needed.
5. Well crafted. Source and testing backed up by CodeClimate and Travis.
6. Open Source.

[![Build Status](https://travis-ci.org/giraldomauricio/rubyboard.svg?branch=master)](https://travis-ci.org/giraldomauricio/rubyboard)
[![Code Climate](https://codeclimate.com/github/giraldomauricio/rubyboard/badges/gpa.svg)](https://codeclimate.com/github/giraldomauricio/rubyboard)
[![Test Coverage](https://codeclimate.com/github/giraldomauricio/rubyboard/badges/coverage.svg)](https://codeclimate.com/github/giraldomauricio/rubyboard/coverage)
[![Issue Count](https://codeclimate.com/github/giraldomauricio/rubyboard/badges/issue_count.svg)](https://codeclimate.com/github/giraldomauricio/rubyboard)