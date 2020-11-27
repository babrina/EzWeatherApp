import Foundation

class Wind: Codable {
    let speed, deg: Double

    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}
