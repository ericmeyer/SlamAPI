module SlamAPI
  class Match
    attr_reader :id, :player_one, :player_two, :completed

    def initialize(attributes)
      @id = SecureRandom.uuid
      @player_one = attributes[:player_one]
      @player_two = attributes[:player_two]
    end
  end
end
