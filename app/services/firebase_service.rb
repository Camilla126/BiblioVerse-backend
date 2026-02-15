# Serviço para conectar ao Firebase
require 'firebase'

class FirebaseService
  def initialize
    base_uri = ENV['FIREBASE_DATABASE_URL']
    secret = ENV['FIREBASE_SECRET']
    @firebase = Firebase::Client.new(base_uri, secret)
  end

  def get(path)
    @firebase.get(path)
  end

  def set(path, data)
    @firebase.set(path, data)
  end

  def push(path, data)
    @firebase.push(path, data)
  end

  def update(path, data)
    @firebase.update(path, data)
  end

  def delete(path)
    @firebase.delete(path)
  end
end
