#Requires YAML
require 'yaml'

#Array for game Objects
$game_arr = Array.new

#Save file for gamedb
$fn = 'game_db.yml'

#Primary superclass for Game
class Game
    def initialize(arr)
        @title = arr[0]
        @released = arr[1]
        @developer = arr[2]
    end

    def getdetails
        return [@title, @released, @developer]
    end
end

#subclass for Nintendo platform, multi-gen
class Nintendo < Game
    def initialize(arr)
        super(arr)
        @nintendo = arr[3]
        @generation = arr[4]
    end

    def getdetails
        return(super << @nintendo << @generation)
    end
end

#subclass for PlayStation platform, multi-gen
class PlayStation < Game
    def initialize(arr)
        super(arr)
        @playstation = arr[3]
        @generation = arr[4]
    end

    def getdetails
        return(super << @playstation << @generation)
    end
end

#subclass for PC games
class PC < Game
    def initialize(arr)
        super(arr)
        @pc = arr[3]
    end

    def getdetails
        return(super << @pc)
    end
end

#Add a Game input, general
def game
    print("Enter Game Title\n> ")
    title = gets().chomp()
    print("Enter the Year it was released\n> ")
    released = gets().chomp()
    print("Who developed the game?\n> ")
    developer = gets().chomp()
    return [@title, @released, @developer]
end

#Add a Nintendo Game input
def ninGame
    gameInfo=(game)
    print("What generation Nintendo? (NES, SNES, N64)\n> ")
    generation = gets().chomp()
    nintendo = ('Nintendo')
    gameInfo << nintendo << generation
    return gameInfo
end

#Add a PlayStation Game input
def psGame
    gameInfo=(game)
    print("What generation PlayStation? (PS1, PS2, PS3, PS4, PS5):> ")
    generation = gets().chomp()
    @playstation = ('PlayStation')
    gameInfo << @playstation << generation
    return gameInfo
end

#Add Game object to the game_db array variable
def addGame(aGame)
    $game_arr << aGame
end

#Save the database
def saveDB
    File.open( $fn, 'w' ) {
        |f|
        f.write($game_arr.to_yaml)
        puts("Saved!")
    }
end

#Load the database
def loadDB
    input_data = File.read($fn)
    $game_arr = YAML.load(input_data)
end

#Show the database
def showData
    puts($game_arr.to_yaml)
end

#Program Start

if File.exists? ($fn) then
    loadDB
    showData
else
    puts("The file #{fn} cannot be found!")
end

#Main Loop
ans = ''
until ans == 'q' do
  puts("Add a (N)intendo or (P)layStation Game - (L)oad List (S)ave or (Q)uit?")
  print("> ")
  ans = gets[0].chr().downcase()
  case ans
    when 'n' then addGame(Nintendo.new(ninGame()))
    when 'p' then addGame(PlayStation.new(psGame()))
    when 'l' then showData
    when 's' then saveDB
  end
end
