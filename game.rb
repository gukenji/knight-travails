require 'pry-byebug'
require_relative 'knight.rb'
require_relative 'tabuleiro.rb'
class Game
    attr_accessor :casa_inicial, :casa_final, :array, :tabuleiro
    def initialize
        puts "Selecione a casa de inicial (a0 até h7):"
        @casa_inicial = gets.chomp
        @casa_inicial = "#{@casa_inicial[0].downcase}#{@casa_inicial[1]}"
        inicio = Knight.new(@casa_inicial)

        puts "Selecione a casa final (a0 até h7):"
        @casa_final = gets.chomp
        @casa_final = "#{@casa_final[0].downcase}#{@casa_final[1]}"
        fim = Knight.new(@casa_final)

        @array = nil
        tabuleiro = Tabuleiro.new
        tabuleiro.adicionar_ids
        tabuleiro.adicionar_vizinhos(inicio.id)
        jogada(inicio,tabuleiro)
        to_s(tabuleiro)
    end

    def jogada(casa,tabuleiro)
        # binding.pry
        array = [] 
        array << @casa_inicial
        fila = []
        fila << casa
        i = 0
        until fila.class == NilClass
            knight = tabuleiro.encontrar_knight(fila[i].id)
            if tabuleiro.casa_encontrada?(knight.vizinhos, @casa_final) == true
                tabuleiro.encontrar_knight(@casa_final).movimento_anterior = knight
                p @casa_final
                fila = nil
            else
                i += 1
                for j in 0..knight.vizinhos.length-1
                    tabuleiro.adicionar_vizinhos(knight.vizinhos[j].id)
                    if array.include?(knight.vizinhos[j].id)
                        next
                    else
                        knight.vizinhos[j].movimento_anterior = knight
                        fila << knight.vizinhos[j]
                        array << knight.vizinhos[j].id
                    end
                end
            end
        end
    end

    def to_s(tabuleiro)
        array = []
        string = ""
        knight = tabuleiro.encontrar_knight(@casa_final)
        until knight.class == NilClass || knight == nil
            array << knight.id
            knight = knight.movimento_anterior
        end
        array.length.downto(0) {|num| (num == array.length || num == 0) ? string << "#{array[num]}" : string << "#{array[num]} --> "}
        puts string
    end

end


