//
//  ViewController.swift
//  CloudyApp
//
//  Created by Mehdican Büyükplevne on 3.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var showBtn: UIButton!
    
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.layer.addSublayer(gradientLayer)
        showBtn.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setBlueGradientBG()
    }
    
    func setBlueGradientBG() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor,bottomColor]
    }

    @IBAction func showButtonTapped(_ sender: UIButton)
    {
        
        let city = cityTextField.text ?? ""
        
        if city.isEmpty {
            let alert = UIAlertController(title: "UYARI!", message: "Lütfen Şehir Seçiniz!", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(identifier: "detailVC") as! DetailViewController
            vc.toCity = city
            self.show(vc, sender: nil)
        }
    }
}

