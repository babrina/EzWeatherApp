import Foundation

class SysNextDays: Codable {
    let pod: Pod

    init(pod: Pod) {
        self.pod = pod
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}
