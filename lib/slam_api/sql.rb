module SlamAPI
  class Sql
    require 'sequel'

    def initialize
      connection = Sequel.connect('postgres://localhost/slamAPI_test')
      @matches = connection[:matches]
    end

    def all
    end

    def matches
    end

    def add(entry)
    end

    def destroy_all
    end

    def destroy_match(id)
    end

    def find_by_id(id)
    end
  end
end
