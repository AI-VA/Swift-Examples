import Foundation


let names = ["alan","brian","charlie"]
let csv = names.reduce("===") {text, name in "\(text),\(name)"}
print(csv) // "===,alan,brian,charlie"
