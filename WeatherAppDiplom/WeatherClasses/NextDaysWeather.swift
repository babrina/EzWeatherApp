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
}
