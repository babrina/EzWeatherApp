import Foundation

class CityJSON: Codable {
    let name: [String]

    init(name: [String]) {
        self.name = name
    }
}
