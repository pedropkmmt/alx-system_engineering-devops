#!/usr/bin/env ruby
# regular expression that will match hbttn
puts ARGV[0].scan(/[hbtn]{2,5}/).join
