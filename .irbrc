###############################################################################
# Color
###############################################################################
# NOTE: need to install the wirble gem
begin
    require 'rubygems'
    require 'wirble'
    Wirble.init
    Wirble.colorize
rescue
    puts "[.irbrc] wirble not available"
end

###############################################################################
# Completion
###############################################################################
begin
    require 'bond'
    require 'bond/completion'
rescue
    puts "[.irbrc] bond not available, using 'irb/completion'"
    require 'irb/completion'
end

