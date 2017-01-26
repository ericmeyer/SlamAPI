module SlamAPI
  class Matches
    class << self
      def all
        matches.values
      end

      def matches
        @matches ||= {}
      end

      def add(match)
        matches[match.id] = match
      end

      def destroy_match(id)
        matches.delete(id)
      end

      def destroy_all
        @matches = {}
      end

      def find_by_id(id)
        matches[id]
      end  

      def pending_matches
        matches.count
      end
    end

    attr_reader :id, :player_one, :player_two, :created_at

    def initialize(attributes)
      @id = SecureRandom.uuid 
      @player_one = attributes[:player_one]
      @player_two = attributes[:player_two]
      @created_at = Time.now
    end

    def create
      if (valid?)
        Matches.add(self)
      end
    end

    def valid?
      player_one != nil && player_two !=nil
    end
  end
end
