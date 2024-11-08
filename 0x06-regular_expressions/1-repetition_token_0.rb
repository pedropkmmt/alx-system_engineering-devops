#!/usr/bin/env ruby
# regular expression that will match hbttn
puts ARGV[0].scan(/hbt{2,5}n/).join
