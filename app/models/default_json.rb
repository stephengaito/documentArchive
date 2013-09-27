module Fandianpf

  # The Fandianpf::DefaultJson class provides the DataMapper model 
  # for recording json object.
  #
  # All of these json objects will be stored in the default database 
  # associated with the current DataMapper, in the fandianpf_json 
  # table.
  class DefaultJson
    include DataMapper::Resource

    property :id,          Serial
    property :objKey,      Text
    property :jsonObject,  Text
  end
end
