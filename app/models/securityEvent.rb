module Fandianpf

  # The Fandianpf::SecurityEvent class provides the DataMapper model 
  # for recording major security events in the life cycle of a 
  # FandianPF webserver.
  #
  # All of these events will be stored in the default database 
  # associated with the current DataMapper, in the 
  # fandianpf_security_event table.
  class SecurityEvent
    include DataMapper::Resource

    property :id,          Serial
    property :description, Text
    property :timeStamp,   DateTime
  end
end
