//
//  recoverPassword.swift
//  Bienestapp
//
//  Created by alumnos on 03/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class changePassword : UIViewController {
    
    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
