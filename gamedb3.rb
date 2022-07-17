#requires yaml format
require 'yaml'

#Global filename for saving
$fn = 'db3.yml'

#load the database from global file
def loadDB
    output = File.new('db3.yml', "r")
    @gamelist = YAML.load(output.read)
end

#save item to global file
def saveDB
    output = File.new('db3.yml', "w")
    output.puts YAML.dump(@gamelist.to_yaml)
    output.close
    print("Saved!\n")
end

#define showdata
def showData
    puts(@gamelist.to_yaml)
end

#gameinfo hash
gameInfo = Hash.new
gameInfo['title']='val1'
gameInfo['platform']='val2'
gameInfo['release']='val3'
gameInfo['developer']='val4'

#append hash to list
def addGame
    output = File.open('db3.yml', "w")
    @gamelist << gameInfo
    output.close
end



#primary class for Game
class Game
    def initialize
        @title = 'val1'
        @platform = 'val2'
        @release = 'val3'
        @developer = 'val4'
    end

    def getdetails
        return (gameInfo.values)
    end
end

#add game user input
def addGame(gameInfo)
    print("Enter Game Title\n> ")
    val1 = gets().chomp()
    print("What platform is the Game on?\n> ")
    val2 = gets().chomp()
    print("Enter the Year it was released\n> ")
    val3 = gets().chomp()
    print("Who developed the game?\n> ")
    val4 = gets().chomp()
    gameInfo << @val1 << @val2 << @val3 << @val4
    return [gameInfo]
end

#main sequence start
if File.exists? ($fn) then
    loadDB
    showData
else
    puts("The file #{fn} cannot be found!")
end

#Main Loop
puts(gameInfo.inspect)
ans = ''
until ans == 'q' do
  puts("Add a (N)ew Game (L)oad List (S)ave or (Q)uit?")
  print("> ")
  ans = gets[0].chr().downcase().chomp()
  case ans
    when 'n' then addGame(Game.new())
    when 'l' then showData
    when 's' then saveDB
    when 'q' then puts("Goodbye!")
    else puts("Invalid entry!")
  end
end