class Knight
    attr_accessor :id, :vizinhos, :movimento_anterior
    def initialize(id)
        @id = id
        @vizinhos = []
        @movimento_anterior = nil
    end

end