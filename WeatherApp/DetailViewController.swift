//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Emre Altundağ on 15.07.2024.
//

import UIKit

class DetailViewController: ViewController {
    var city = String()

    @IBOutlet var Weather: UILabel!
    @IBOutlet var Description: UILabel!
    @IBOutlet var cityName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = city
        result(cityName: city)
    }

    func result(cityName: String) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef") {
            let request = URLRequest(url: url)

            let task = URLSession.shared.dataTask(with: request) { data, _, eror in

                if eror == nil {
                    if let incomingData = data {
                        do {
                            let Json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject

                            if let main = Json["main"] as? NSDictionary {
                                if let temp = main["temp"] as? Double {
                                    let state = Int(temp - 273.15)

                                    print(Json)

                                    DispatchQueue.main.async {
                                        self.Weather.text = String(state) + "°C"
                                    }
                                }
                            }
                            if let weatherArray = Json["weather"] as? [[String: Any]] { // weather anahtarını dizi olarak alıyoruz
                                if let weather = weatherArray.first { // dizinin ilk elemanını alıyoruz
                                    if let description = weather["description"] as? String {
                                        DispatchQueue.main.sync {
                                            self.Description.text = description
                                        }
                                    }
                                }
                            }

                        } catch {
                            print("Bir hata oluştu")
                        }
                    }
                }
            }

            task.resume()
        }
    }
}
