//
//  userController.swift
//  Bienestapp
//
//  Created by alumnos on 03/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit
import UserNotifications

class userController : UIViewController {
    
    var json: [String:Any]??
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    @IBAction func getPermission(_ sender: Any) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (autorizado, error) in
            if autorizado {
                let alert1 = UIAlertAction(title:"OK", style: UIAlertAction.Style.default) {
                    (error) in
                }
                let alert = UIAlertController(title: "Aviso", message:
                    "Permiso Concedido", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
                print("permiso concedido")
            } else {
                let alert1 = UIAlertAction(title:"OK", style: UIAlertAction.Style.default) {
                    (error) in
                }
                let alert = UIAlertController(title: "Aviso", message:
                    "Permiso Denegado", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
                print("Permiso no concedido", error?.localizedDescription)
            }
        }
    }
    
    func getUser() {
        let url = URL (string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/mostrarUsuario")
        
        let header = ["Authorization": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.response!.statusCode == 201 {
                self.json = response.result.value as? [String:Any]
                self.nameUser.text = self.json!!["name"] as? String
            } else {
                
                let alert1 = UIAlertAction(title:"Cerrar", style: UIAlertAction.Style.default) {
                    (error) in
                }
                let alert = UIAlertController(title: "Error", message:
                    "Informacion Incorrecta", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

