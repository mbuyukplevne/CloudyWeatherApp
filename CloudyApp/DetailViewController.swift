//
//  DetailViewController.swift
//  CloudyApp
//
//  Created by Mehdican Büyükplevne on 3.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cityNameTF: UILabel!
    @IBOutlet weak var celsiumTF: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var toCity = String()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getResult(cityName: toCity)
        bgImageView.layer.addSublayer(gradientLayer)
        cityNameTF.text = toCity
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setBlueGradientBG()
        }
    
    
    func setBlueGradientBG()
    {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor,bottomColor]
    }
    
    func getResult(cityName: String)
    {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    if let incomingData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            //print(json)
                            
                            if let main = json["main"] as? NSDictionary {
                                if let temp = main["temp"] as? Double {
                                    let state = Int(temp - 273.15)
                                    
                                    DispatchQueue.main.async {
                                        self.celsiumTF.text = String(state)
                                    }
                                }
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
