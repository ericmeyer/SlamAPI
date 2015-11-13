module SlamAPI
  class Memory
    def initialize
      @storage = {}
    end

    def all
      @storage.values
    end

    def matches
      @storage.values
    end

    def add(entry)
      @storage[entry.id] = entry
    end

    def destroy_all
      @storage = {}
    end

    def destroy_match(id)
      @storage.delete(id)
    end

    def find_by_id(id)
      @storage[id]
    end
  end
end
