//
//  showAppController.swift
//  Bienestapp
//
//  Created by alumnos on 04/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class showAppController: UIViewController {
    
    
    var nombre: String = ""
    var imagen: UIImage? = nil
    var time: String = ""
    var date: String = ""
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    @IBOutlet weak var dateApp: UILabel!
    @IBOutlet weak var timeApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameApp.text! = nombre
        imageApp.image = imagen
        dateApp.text! = "Fecha: " + date
        timeApp.text! = "Tiempo acumulado: " + time + " segundos"
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
