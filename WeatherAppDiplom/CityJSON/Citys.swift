
import Foundation
struct Citys {
    let names: [String]
}

extension Citys: Decodable {
    
    private enum Key: String, CodingKey {
        case names = "Cities"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        self.names = try container.decode([String].self, forKey: .names)
    }
}


