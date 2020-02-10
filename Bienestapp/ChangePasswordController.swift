//
//  ChangePasswordController.swift
//  Bienestapp
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit

class ChangePasswordController: UIViewController {
    
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confimrPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update(_ sender: Any) {
        if newPass.text!.isEmpty || confimrPass.text!.isEmpty{
            print("Hola")
        } else if newPass.text! == confimrPass.text! {
            user.password = newPass.text!
            updatePass(user: user)
            dismiss(animated: true, completion: nil)
        } else {
            print("Adios")
        }
    }
    
    func updatePass(user: User) {
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/updatePassword")
        
        let header = ["Authorization": token]
        let json = ["password": user.password]
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            
        }
    }
    
    
}
