module Discobolo
  class Client < Disque

    def show(id)
      Hash[ *call("SHOW", id)]
    end

  end
end