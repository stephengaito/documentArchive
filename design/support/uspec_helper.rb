# This is a place holder for any code which supports the USpec specifications

# Turn on or off USpec logging
#
# @param [Boolean] loggingOn whether or not to log uspec information
# @return not specified
def setUSpecLogging(loggingOn, fileName = nil)
  $uSpecLogging = loggingOn;
#  unless fileName.nil? then
#    fileName.sub!(/^.*fandianpf\//,'') 
#    puts "USpecLogging: #{loggingOn} in #{fileName}";
#  end
end

# Returns the current state of USpecLogging.
#
# @return [Boolean] the current state of USpecLogging
def uSpecLogging
  $uSpecLogging
end

