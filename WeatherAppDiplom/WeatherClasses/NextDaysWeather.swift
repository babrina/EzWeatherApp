import Foundation

class NextDaysWeather: Codable {
    var nextThreeHours: String = ""
    var nextThreeHoursPicture: String = ""
    var nextThreeHoursTemp: String = ""
    var nextSixHours: String = ""
    var nextSixHoursTemp: String = ""
    var nextSixHoursPicture: String = ""
    var nextEightHours: String = ""
    var nextEightHoursTemp: String = ""
    var nextEightHoursPicture: String = ""
    var nextTwelveHours: String = ""
    var nextTwelveHoursTemp: String = ""
    var nextTwelveHoursPicture: String = ""
    

    var nextDay: String = ""
    var nextDayPicture: String = ""
    var nextDayTemp: String = ""
    
    var secondNextDay: String = ""
    var secondNextDayPicture: String = ""
    var secondNextDayTemp: String = ""
    
    
    var thirdNextDay: String = ""
    var thirdNextDayPicture: String = ""
    var thirdNextDayTemp: String = ""
    
    var fourthNextDay: String = ""
    var fourthNextDayPicture: String = ""
    var fourthNextDayTemp: String = ""
    
    var fifthNextDay: String = ""
    var fifthNextDayPicture: String = ""
    var fifthNextDayTemp: String = ""

    convenience init() {
        self.init(nextThreeHours: "", nextThreeHoursPicture: "", nextThreeHoursTemp: "",  nextSixHoursTemp: "", nextSixHours: "", nextSixHoursPicture: "", nextEightHours: "", nextEightHoursTemp: "", nextEightHoursPicture: "", nextTwelveHours: "", nextTwelveHoursTemp: "", nextTwelveHoursPicture: "", nextDay: "", nextDayPicture: "", nextDayTemp: "", secondNextDay: "", secondNextDayPicture: "", secondNextDayTemp: "", thirdNextDay: "", thirdNextDayTemp: "", thirdNextDayPicture: "", fourthNextDay: "", fourthNextDayPicture: "", fourthNextDayTemp: "",  fifthNextDay: "", fifthNextDayPicture: "", fifthNextDayTemp: "")
    }
    
    init(nextThreeHours: String, nextThreeHoursPicture: String, nextThreeHoursTemp: String, nextSixHoursTemp: String, nextSixHours: String, nextSixHoursPicture: String, nextEightHours: String, nextEightHoursTemp: String, nextEightHoursPicture: String, nextTwelveHours: String, nextTwelveHoursTemp: String, nextTwelveHoursPicture: String, nextDay: String, nextDayPicture: String, nextDayTemp: String, secondNextDay: String, secondNextDayPicture: String, secondNextDayTemp: String, thirdNextDay: String, thirdNextDayTemp: String, thirdNextDayPicture: String, fourthNextDay: String, fourthNextDayPicture: String, fourthNextDayTemp: String, fifthNextDay: String, fifthNextDayPicture: String, fifthNextDayTemp: String) {
        self.nextThreeHours = nextThreeHours
        self.nextThreeHoursTemp = nextThreeHoursTemp
        self.nextThreeHoursPicture = nextThreeHoursPicture
        
        self.nextSixHours = nextSixHours
        self.nextSixHoursTemp = nextSixHoursTemp
        self.nextSixHoursPicture = nextSixHoursPicture
        
        self.nextEightHours = nextEightHours
        self.nextEightHoursTemp = nextEightHoursTemp
        self.nextEightHoursPicture = nextEightHoursPicture
        
        self.nextTwelveHours = nextTwelveHours
        self.nextTwelveHoursTemp = nextTwelveHoursTemp
        self.nextTwelveHoursPicture = nextTwelveHoursPicture

        self.nextDay = nextDay
        self.nextDayPicture = nextDayPicture
        self.nextDayTemp = nextDayTemp
        
        self.secondNextDayPicture = secondNextDayPicture
        self.secondNextDayTemp = secondNextDayTemp
        self.secondNextDay = secondNextDay
        
        self.thirdNextDayPicture = thirdNextDayPicture
        self.thirdNextDayTemp = thirdNextDayTemp
        self.thirdNextDay = thirdNextDay
       
        self.fourthNextDayPicture = fourthNextDayPicture
        self.fourthNextDayTemp = fourthNextDayTemp
        self.fourthNextDay = thirdNextDay
        
        self.fifthNextDayPicture = fifthNextDayPicture
        self.fifthNextDayTemp = fifthNextDayTemp
        self.fifthNextDay = fifthNextDay
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case nextThreeHours, nextThreeHoursPicture, nextThreeHoursTemp, nextSixHours, nextSixHoursTemp, nextSixHoursPicture, nextEightHours, nextEightHoursPicture, nextEightHoursTemp, nextTwelveHours, nextTwelveHoursTemp, nextTwelveHoursPicture, nextDay, nextDayPicture, nextDayTemp, secondNextDay, secondNextDayTemp, secondNextDayPicture, thirdNextDay, thirdNextDayTemp, thirdNextDayPicture, fourthNextDay, fourthNextDayPicture, fourthNextDayTemp, fifthNextDay, fifthNextDayPicture, fifthNextDayTemp
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nextThreeHours = try container.decode(String.self, forKey: .nextThreeHours)
        self.nextThreeHoursPicture = try container.decode(String.self, forKey: .nextThreeHoursPicture)
        self.nextThreeHoursTemp = try container.decode(String.self, forKey: .nextThreeHoursTemp)

        
        self.nextSixHours = try container.decode(String.self, forKey: .nextSixHours)
        self.nextSixHoursTemp = try container.decode(String.self, forKey: .nextSixHoursTemp)
        self.nextSixHoursPicture = try container.decode(String.self, forKey: .nextSixHoursPicture)

        self.nextEightHours = try container.decode(String.self, forKey: .nextEightHours)
        self.nextEightHoursPicture = try container.decode(String.self, forKey: .nextEightHoursPicture)
        self.nextEightHoursTemp = try container.decode(String.self, forKey: .nextEightHours)
        
        self.nextTwelveHours = try container.decode(String.self, forKey: .nextTwelveHours)
        self.nextTwelveHoursTemp  = try container.decode(String.self, forKey: .nextTwelveHoursTemp)
        self.nextTwelveHoursPicture = try container.decode(String.self, forKey: .nextTwelveHoursPicture)
        
        self.nextDay = try container.decode(String.self, forKey: .nextDay)
        self.nextDayPicture = try container.decode(String.self, forKey: .nextDayPicture)
        self.nextDayTemp = try container.decode(String.self, forKey: .nextDayTemp)
        
        self.secondNextDayTemp = try container.decode(String.self, forKey: .secondNextDayTemp)
        self.secondNextDayPicture = try container.decode(String.self, forKey: .secondNextDayPicture)
        self.secondNextDay = try container.decode(String.self, forKey: .secondNextDay)
        
        self.thirdNextDayTemp = try container.decode(String.self, forKey: .thirdNextDayTemp)
        self.thirdNextDayPicture = try container.decode(String.self, forKey: .thirdNextDayPicture)
        self.thirdNextDay = try container.decode(String.self, forKey: .thirdNextDay)
        
        self.fourthNextDayTemp = try container.decode(String.self, forKey: .fourthNextDayTemp)
        self.fourthNextDayPicture = try container.decode(String.self, forKey: .fourthNextDayPicture)
        self.fourthNextDay = try container.decode(String.self, forKey: .fourthNextDay)
        
        self.fifthNextDay = try container.decode(String.self, forKey: .fifthNextDay)
        self.fifthNextDayPicture = try container.decode(String.self, forKey: .fifthNextDayPicture)
        self.fifthNextDayTemp = try container.decode(String.self, forKey: .fifthNextDayTemp)
     

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.nextThreeHours, forKey: .nextThreeHours)
        try container.encode(self.nextThreeHoursPicture, forKey: .nextThreeHoursPicture)
        try container.encode(self.nextThreeHoursTemp, forKey: .nextThreeHoursTemp)

        try container.encode(self.nextSixHours, forKey: .nextSixHours)
        try container.encode(self.nextSixHoursTemp, forKey: .nextSixHoursTemp)
        try container.encode(self.nextSixHoursPicture, forKey: .nextSixHoursPicture)
        
        try container.encode(self.nextEightHours, forKey: .nextEightHours)
        try container.encode(self.nextEightHoursTemp, forKey: .nextEightHoursTemp)
        try container.encode(self.nextEightHoursPicture, forKey: .nextEightHoursPicture)
        
        try container.encode(self.nextTwelveHours, forKey: .nextTwelveHours)
        try container.encode(self.nextTwelveHoursTemp, forKey: .nextTwelveHoursTemp)
        try container.encode(self.nextTwelveHoursPicture, forKey: .nextTwelveHoursPicture)
        
        try container.encode(self.nextDay, forKey: .nextDay)
        try container.encode(self.nextDayPicture, forKey: .nextDayPicture)
        try container.encode(self.nextDayTemp, forKey: .nextDayTemp)
        
        try container.encode(self.secondNextDay, forKey: .secondNextDay)
        try container.encode(self.secondNextDayPicture, forKey: .secondNextDayPicture)
        try container.encode(self.secondNextDayTemp, forKey: .secondNextDayTemp)
        
        try container.encode(self.thirdNextDay, forKey: .thirdNextDay)
        try container.encode(self.thirdNextDayPicture, forKey: .thirdNextDayPicture)
        try container.encode(self.thirdNextDayTemp, forKey: .thirdNextDayTemp)
        
        try container.encode(self.fourthNextDay, forKey: .fourthNextDay)
        try container.encode(self.fourthNextDayPicture, forKey: .fourthNextDayPicture)
        try container.encode(self.fourthNextDayTemp, forKey: .fourthNextDayTemp)
       
        try container.encode(self.fifthNextDay, forKey: .fifthNextDay)
        try container.encode(self.fifthNextDayPicture, forKey: .fifthNextDayPicture)
        try container.encode(self.fifthNextDayTemp, forKey: .fifthNextDayTemp)
    }
    
}
