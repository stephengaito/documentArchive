module Fandianpf
  class SecurityEvent
    include DataMapper::Resource

    property :id,          Serial
    property :description, Text
    property :timeStamp,   DateTime
  end
end
