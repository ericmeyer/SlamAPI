module SlamAPI
  module Matches
    class Repository
      def initialize(db)
        @db = db
      end

      def all
        db.all
      end

      def create(match)
        db.add(match) if valid?(match)
      end

      def destroy_all
        db.destroy_all
      end

      def destroy_match(id)
        db.destroy_match(id)
      end

      def find_by_id(id)
        db.find_by_id(id)
      end

      private

      attr_accessor :db

      def valid?(match)
        match.player_one != nil && match.player_two !=nil
      end
    end
  end
end

