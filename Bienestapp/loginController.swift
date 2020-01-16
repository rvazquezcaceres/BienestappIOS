//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
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
        var errores = true
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
            // crear usuario en la api
            print("nombre: ", user.name
                + " Email: ", user.email + " Password: ", user.password)
        }else{
            print("Con errores no llegamos a ningun lado")
        }
    }
}

