#!/usr/bin/env ruby
# regular expression that will match hb
puts ARGV[0].scan(/hbt{2,5}n/).join
