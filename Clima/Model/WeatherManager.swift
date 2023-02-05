//
//  weatherManager.swift
//  Clima
//
//  Created by hassan on 05/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=dc5fb995f55bf422494048a796d4121b&units=metric"
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performeRequest(urlString: urlString)
    }
    func performeRequest(urlString: String){
        if let URL = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: URL) { data, response, error in
                if error != nil{
                    print(error!)
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodeedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodeedData.weather[0].id)
            let temp = decodeedData.main.temp
            let name = decodeedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
        }catch{
            print(error)
        }
    }
    
}
