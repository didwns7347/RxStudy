protocol Planet {
    var weather: String { get }
}

extension Planet {
    var weather: String { "Deadly Cold 🥶" }
    var habitable: Bool { false }
    
}

// MARK: - Implementation

struct Earth: Planet {
    var weather: String { "Comfortable 🌱" }
    var habitable: Bool { true }
}

let localEarth: Planet = Earth()
let localWeather = localEarth.weather
let localHabitable = localEarth.habitable
print(localWeather)
print(localHabitable)
