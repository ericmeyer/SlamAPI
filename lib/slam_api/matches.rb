module SlamAPI
  class Matches
    class << self
      def all
        matches
      end

      def pending_matches
        matches.select { |match| match.completed? == false }
      end

      def matches
        @matches ||= []
      end

      def add(match)
        matches << match
      end

      def destroy_all
        @matches = []
      end

      def find_by_id(id)
        matches.select {|match| match.id == id}.first
      end  
    end

    attr_reader :id, :player_one, :player_two, :completed

    def initialize(attributes)
      @id = SecureRandom.uuid 
      @player_one = attributes[:player_one]
      @player_two = attributes[:player_two]
      @completed = false
    end

    def create
      if (valid?)
        Matches.add(self)
      end
    end

    def completed?
      completed
    end

    def complete_game
      @completed = true
    end

    def valid?
      player_one != nil && player_two !=nil
    end
  end
end
