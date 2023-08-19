//
//  ContentView.swift
//  Weather App
//
//  Created by Afrah Faisal on 01/02/1445 AH.
//

import SwiftUI

struct ContentView: View {
  
    @State private var cityName = ""
    @State var weather : Weather?

    let session: URLSession = .shared
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView {
                    Image("images")
                        .font(.largeTitle)
                        .scaledToFit()
                        .padding()
                    Text("Weather Info")
                        .font(.title)
                        .padding()
                    TextField(" Enter City", text: $cityName )
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        .padding()
                    NavigationLink {
                        WeatherInfo()
                    }
                label:{
                    Text("Get start")
                        .frame(minWidth: 50, maxWidth: 150)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.yellow, lineWidth: 5))
                        .background(Color.yellow)
                        .cornerRadius(16)
                }
                    NavigationLink{
                        AddNewCity()
                    }label: {
                        Text("add new city")
                            .frame(minWidth: 50, maxWidth: 150)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.yellow, lineWidth: 5))
                            .background(Color.yellow)
                            .cornerRadius(16)
                            .padding(5)
                    }
                }
            }
        }
        .padding()
        .onChange(of: cityName, perform: {
            newValue in
            fetchRequest(value: newValue)
        })
    }
    func fetchRequest(value : String){
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

