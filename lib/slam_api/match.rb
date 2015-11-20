module SlamAPI
  class Match
    attr_reader :id, :player_one, :player_two

    def initialize(attributes)
      @id = attributes[:id] ? attributes[:id] : SecureRandom.uuid
      @player_one = attributes[:player_one]
      @player_two = attributes[:player_two]
    end

    def attributes
      {id: id,
       player_one: player_one,
       player_two: player_two}
    end
  end
end
