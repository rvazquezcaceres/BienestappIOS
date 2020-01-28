//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Alamofire
import UIKit
var token: String = ""

class loginController: UIViewController {

    @IBOutlet weak var prueba: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: Any) {
        var errores = false
        if(emailInput.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.email = emailInput.text!
            errorEmail.isHidden = true
        }
        
        if(passwordInput.text!.isEmpty){
            errores = true
            errorPassword.isHidden = false
        }else{
            user.password = passwordInput.text!
            errorPassword.isHidden = true
        }
        
        if(!errores){
            postUser(user: user)
            print("logueado mamon")
            // crear usuario en la api
//            print("nombre: ", user.name
//                + " Email: ", user.email + " Password: ", user.password)
        }else{
            print(user.password)
            print(user.email)
            print("Con errores no llegamos a ningun lado")
        }
        
    }
    func postUser(user: User) {
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/login")
        let json = ["email": user.email,
                    "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.performSegue(withIdentifier: "CorrectLogin", sender: nil)
                var json = response.result.value as! [String: AnyObject]
                token = json["token"] as! String
                print(token)
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
