module Fandianpf

  # The Fandianpf::SecurityEvent class provides the DataMapper model 
  # for recording major security events in the life cycle of a 
  # FandianPF webserver.
  #
  # All of these events will be stored in the default database 
  # associated with the current DataMapper, in the 
  # fandianpf_security_event table.
  #
  # @note Using Sequel semantics, SecurityEvent will be associated with 
  #   the *first* database opened, which *should* be the only one 
  #   opened by the PersistentStore class.  (See Sequel::DATABASES 
  #   contant).
  #
  class SecurityEvent < Sequel::Model
  end
end
