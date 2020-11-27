import Foundation

class WindNextDays: Codable {
    let speed: Double
    let deg: Double

    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}
