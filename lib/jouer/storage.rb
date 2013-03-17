module Jouer
  module Storage
    STORAGE = {
      'history' => { write: :zadd, key: 'games/history' }
    }
    
    def redis
      Connection.db
    end
    alias :store :redis

    def write(key, *opts)
      redis.send(STORAGE[key][:write], STORAGE[key][:key], *opts)
    end

    def read(key, *opts)
      redis.send(STORAGE[key][:read], key, *opts)
    end
    
  end
end