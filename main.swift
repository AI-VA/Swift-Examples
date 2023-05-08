import Foundation


protocol Dog {
  var paws: Int { get }
  var weight: Float { get set}
  var commands: [String] { set get }
}

class Doberman: Dog {
  private (set) var paws: Int = 4
  var weight: Float = 25.4
  var commands: [String] = ["Stand up", "lie down", "vote", "nearby", "enemy", "give a paw"]
 
}
 
class Mastiff: Dog {
  var paws: Int = 4
  var weight: Float = 27.5
  var commands: [String] = ["sit down", "lie down", "enemy", "give a paw"]
}
 
let tatarin = Doberman()
print(tatarin.paws)
print(tatarin.weight)
print(tatarin.commands)
 
//tatarin.paws = 6
tatarin.weight = 44
tatarin.commands.append("sit down")
 
var bigBoy: Dog = Mastiff()
print(bigBoy.paws)
print(bigBoy.weight)
print(bigBoy.commands)
 
//bigBoy.paws = 6
bigBoy.weight = 60
bigBoy.commands.append("vote")
