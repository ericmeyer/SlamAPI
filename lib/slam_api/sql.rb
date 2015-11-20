module SlamAPI
  class Sql
    require 'sequel'

    def initialize
      connection = Sequel.connect("postgres://localhost/slamAPI_#{ENV['ENV']}")
      @matches = connection[:matches]
    end

    def all
      matches.all.reduce([]) do |records, match|
        records << convert(match)
      end
    end

    def matches
    end

    def add(entry)
      matches.insert(entry.attributes)
    end

    def destroy_all
      matches.truncate
    end

    def destroy_match(id)
      matches.where(id: "#{id}").delete
    end

    def find_by_id(id)
      convert(matches.filter(id: "#{id}").first)
    end

    def convert(attributes)
      Match.new(attributes)
    end

    private

    attr_reader :matches
  end
end
