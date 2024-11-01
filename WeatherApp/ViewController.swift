//
//  ViewController.swift
//  WeatherApp
//
//  Created by Emre Altundağ on 14.07.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Btn: UIButton!
    @IBOutlet var TextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if Btn == nil {
            print("Btn is nil")
        } else {
            Btn.layer.cornerRadius = 10
        }
    }

    // override func viewWillAppear(_ animated: Bool) {     //  navigation barı olmadan çalıştırır
    //  self.navigationController?.navigationBar.isHidden = true
    // }

    @IBAction func btn(_ sender: Any) {
        let city = TextField.text ?? ""

        if city.isEmpty {
            let alert = UIAlertController(title: "Uyarı", message: "Şehir adı boş olamaz", preferredStyle: .alert)

            let Cancelbtn = UIAlertAction(title: "Geri", style: .cancel, handler: nil)

            alert.addAction(Cancelbtn)

            present(alert, animated: true, completion: nil)

        } else {
            if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
                vc.city = city

                show(vc, sender: nil)
            }
        }
    }
}
