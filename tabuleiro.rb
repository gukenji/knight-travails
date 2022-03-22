require_relative 'knight.rb'
class Tabuleiro
    attr_accessor :knights
    def initialize
        @knights =[]
    end

    def adicionar_knight(id)
        @knights << Knight.new(id)
    end

    def adicionar_ids
        for i in 'a'..'h'
            for j in 0..7
                self.adicionar_knight("#{i}#{j}")
            end
        end
    end

    def encontrar_knight(id)
        knights.each do |v|
            return v if v.id == id
        end
        nil
    end
    
    def caracter_para_numero(caracter,deslocamento)
        letra = caracter.ord + deslocamento
        letra = letra.chr
        return letra
    end

    def adicionar_vizinhos(id)
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],-2)}#{id[1].to_i+1}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],-2)}#{id[1].to_i-1}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],2)}#{id[1].to_i+1}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],2)}#{id[1].to_i-1}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],1)}#{id[1].to_i+2}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],1)}#{id[1].to_i-2}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],-1)}#{id[1].to_i+2}")
        self.encontrar_knight(id).vizinhos << self.encontrar_knight("#{caracter_para_numero(id[0],-1)}#{id[1].to_i-2}")
        self.encontrar_knight(id).vizinhos.compact!
    end

    def casa_encontrada?(array, casa)
        encontrado = false
        array.each do |v|
            unless v == nil
                if v.id == casa
                    encontrado = true
                    break
                else
                    next
                end
            end
        end
        encontrado
    end     
end