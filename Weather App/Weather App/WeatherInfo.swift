//
//  WeatherInfo.swift
//  Weather App
//
//  Created by Afrah Faisal on 02/02/1445 AH.
//

import SwiftUI
let backgroundGradient = LinearGradient(
    colors: [Color.black, Color.blue],
    startPoint: .top, endPoint: .bottom)
struct WeatherInfo: View {
    let session: URLSession = .shared
    @State private var cityName = ""
    @State var weather : Weather?
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundGradient
                VStack{
//                    ScrollView {
                        HStack{
                            Text(weather?.name ?? "")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                             
                            Text(weather?.sys.country ?? "")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                        }
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/02n@2x.png"))
                        
                        Text(weather?.main.temp.description ?? "")
                            .foregroundColor(.white)
                            .padding()
                        HStack{
                            Text( weather?.main.tempMax.description ?? "")
                                .foregroundColor(.white)
                            Text(weather?.main.tempMin.description ?? "")
                                .foregroundColor(.white)
                        }
                        .padding()
                        ForEach(weather?.weather ?? [] , id: \.self){
                            value in
                            Text(value.description)
                                .foregroundColor(.white)
                        }
                        .padding()
                    HStack{
                        Text(weather?.wind.speed.description ?? "")
                            .foregroundColor(.white)
                        Text(weather?.main.humidity.description ?? "")
                            .foregroundColor(.white)
                    }
                    }
//                }
            }
            .ignoresSafeArea()
            }
        .onAppear(){
            weatherdata()
        }
    }
    
        func weatherdata()
            {
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=21.492500&lon=39.177570&appid=") else {
                    return
                }
                var requst = URLRequest(url: url)
                requst.setValue("d53e7b7dd77bc8949151f94b782a351c", forHTTPHeaderField: "x-api-key")

                let task = session.dataTask(with: requst){
                    (data, response, error) in
                    if let error = error{
                        print("error")
                        return
                    }
                    if let data = data{
                        if let content = String(bytes: data, encoding: .utf8){
                            let decoder = JSONDecoder()
                            do{
                                let weatherdata = try decoder.decode(Weather.self, from: data)
                                weather = weatherdata
                                print(weatherdata)
                            }
                            catch{
                                print(error)
                            }
                        }

                    }
                }
                task.resume()
            }
    
}

struct WeatherInfo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfo()
    }
}
