#requires yaml format
require 'yaml'

#Global filename for saving
$fn = 'db3.yml'

class GameDB
    #load the database from global file
    def initialize
        begin
            output = File.new('db3.yml', "r")
            @gamelist = YAML.load(output.read)
        rescue => ex
            puts ex.message
        ensure
            @gamelist ||= []
            puts @gamelist.inspect
        end
    end
    
    #save item to global file
    def saveDB
        output = File.new('db3.yml', "w")
        output.puts YAML.dump(@gamelist)
        output.close
        print("Saved!\n")
    end
    
    #define showdata
    def showData
        @gamelist.each do |game|
            puts game
        end
    end

    def addGame(game)
        @gamelist << game
    end
end


#primary class for Game
class Game
    attr_accessor :title, :platform, :release, :developer

    def getdetails
        return (gameInfo.values)
    end
    
    def to_s
        "#{self.title}: (#{self.platform} - #{self.release} - #{self.developer})"
    end
end

#add game user input
def inputGame
    game = Game.new()
    print("Enter Game Title\n> ")
    game.title = gets().chomp()
    print("What platform is the Game on?\n> ")
    game.platform = gets().chomp()
    print("Enter the Year it was released\n> ")
    game.release = gets().chomp()
    print("Who developed the game?\n> ")
    game.developer = gets().chomp()
    return game
end

#main sequence start
# if File.exists? ($fn) then
#     loadDB
#     showData
# else
#     puts("The file #{fn} cannot be found!")
# end

#Main Loop
db = GameDB.new()
db.showData()
ans = ''
until ans == 'q' do
  puts("Add a (N)ew Game (L)oad List (S)ave or (Q)uit?")
  print("> ")
  ans = gets[0].chr().downcase().chomp()
  case ans
    when 'n' 
        game = inputGame()
        db.addGame(game)
    when 'l' 
        db.showData
    when 's' 
        db.saveDB
    when 'q' 
        puts("Goodbye!")
    else 
        puts("Invalid entry!")
  end
end