require 'pry-byebug'
class Vertice
    attr_accessor :id, :vizinhos, :movimento_anterior
    def initialize(id)
        @id = id
        @vizinhos = []
        @movimento_anterior = nil
    end

end

class Grafo
    attr_accessor :vertices
    def initialize
        @vertices =[]
    end

    def adicionar_vertice(id)
        @vertices << Vertice.new(id)
    end

    def adicionar_ids
        for i in 'a'..'h'
            for j in 0..7
                self.adicionar_vertice("#{i}#{j}")
            end
        end
    end

    def encontrar_vertice(id)
        vertices.each do |v|
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
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],-2)}#{id[1].to_i+1}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],-2)}#{id[1].to_i-1}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],2)}#{id[1].to_i+1}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],2)}#{id[1].to_i-1}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],1)}#{id[1].to_i+2}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],1)}#{id[1].to_i-2}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],-1)}#{id[1].to_i+2}")
        self.encontrar_vertice(id).vizinhos << self.encontrar_vertice("#{caracter_para_numero(id[0],-1)}#{id[1].to_i-2}")
        self.encontrar_vertice(id).vizinhos.compact!
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



class Game
    attr_accessor :casa_inicial, :casa_final, :array, :grafo
    def initialize
        puts "Selecione a casa de @casa_inicial (a0 até h7):"
        @casa_inicial = gets.chomp
        @casa_inicial = "#{@casa_inicial[0].downcase}#{@casa_inicial[1]}"
        inicio = Vertice.new(@casa_inicial)

        puts "Selecione a casa @casa_final (a0 até h7):"
        @casa_final = gets.chomp
        @casa_final = "#{@casa_final[0].downcase}#{@casa_final[1]}"
        fim = Vertice.new(@casa_final)

        @array = nil
        grafo = Grafo.new
        grafo.adicionar_ids
        grafo.adicionar_vizinhos(inicio.id)
        jogada(inicio,grafo)
        to_s(grafo)
    end

    def jogada(casa,grafo)
        # binding.pry
        array = [] 
        array << @casa_inicial
        fila = []
        fila << casa
        i = 0
        until fila.class == NilClass
            vertice = grafo.encontrar_vertice(fila[i].id)
            if grafo.casa_encontrada?(vertice.vizinhos, @casa_final) == true
                grafo.encontrar_vertice(@casa_final).movimento_anterior = vertice
                p @casa_final
                fila = nil
            else
                i += 1
                for j in 0..vertice.vizinhos.length-1
                    grafo.adicionar_vizinhos(vertice.vizinhos[j].id)
                    if array.include?(vertice.vizinhos[j].id)
                        next
                    else
                        vertice.vizinhos[j].movimento_anterior = vertice
                        fila << vertice.vizinhos[j]
                        array << vertice.vizinhos[j].id
                    end
                end
            end
        end
    end

    def to_s(grafo)
        array = []
        string = ""
        vertice = grafo.encontrar_vertice(@casa_final)
        until vertice.class == NilClass || vertice == nil
            array << vertice.id
            vertice = vertice.movimento_anterior
        end
        array.length.downto(0) {|num| (num == array.length || num == 0) ? string << "#{array[num]}" : string << "#{array[num]} --> "}
        puts string
    end

end


a = Game.new
