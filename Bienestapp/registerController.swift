//

import UIKit
var user = User()
class registerController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        var errores = false
        
        if(nameInput.text!.isEmpty){
            errores = true
            errorName.isHidden = false
        }else{
            user.name = nameInput.text!
            errorName.isHidden = true
        }
        
        if(emailInput.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.email = emailInput.text!
            errorName.isHidden = true
        }
        
        if(passwordInput.text!.isEmpty){
            errores = true
            errorPassword.isHidden = false
        }else{
            user.password = passwordInput.text!
            errorName.isHidden = true
        }
        
        
        if(!errores){
            // crear usuario en la api
            print("nombre: ", user.name
                + " Email: ", user.email + "Password: ", user.password)
        }else{
            print("Con errores no llegamos a ningun lado")
        }
    }
}

