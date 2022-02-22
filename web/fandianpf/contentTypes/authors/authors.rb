module Fandianpf

  class Authors < ContentType

    # ::install installs this content type.
    #
    def self.install
      registerFields :authors, 
        [ :surname, :von, :firstname, :jr, :institute, :notes ]
      registerDescription <<END_DESCRIPTION 
Authors allow you to keep notes, as well as contact details about 
authors you are interested in.
END_DESCRIPTION
    end

    # ::listMigrations lists any and all migrations associated with 
    # this content type.
    #
    def self.listMigrations

      # create the base table reqired to index author JSON objects.
      migration(1) do 
        up do
          create_table :authors do
            String :surname,   :text=>true, :index=>true
            String :von,       :text=>true, :index=>true
            String :firstname, :text=>true, :index=>true
            String :jr,        :text=>true, :index=>true
            String :institute, :text=>true, :index=>true
            String :notes,     :text=>true, :index=>true
          end
        end
        down do
          drop_table :authors;
        end
      end
    end

  end


end
