module Fandianpf

  # The Fandianpf::DefaultJson class provides the DataMapper model 
  # for recording json object.
  #
  # All of these json objects will be stored in the default database 
  # associated with the current DataMapper, in the fandianpf_json 
  # table.
  #
  # @note Using Sequel semantics, JsonObject will be associated with 
  #   the *first* database opened, which *should* be the only one 
  #   opened by the PersistentStore class.  (See Sequel::DATABASES 
  #   contant).
  #
  class JsonObject < Sequel::Model
  end
end
