module SlamAPI
  module Matches
    class MatchesRepository
      class << self

        def matches
          @matches ||= {}
        end

        def save(match)
          matches[match.id] = match
        end

        def all
          matches.values
        end

        def find_by_id(id)
          matches[id]
        end
      end
    end
  end
end

