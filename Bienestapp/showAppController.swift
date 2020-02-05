//
//  showAppController.swift
//  Bienestapp
//
//  Created by alumnos on 04/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class showAppController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var json: String = ""
    var jsonUso: [[String:Any]]?
    var numberJson = 0
    
    var nombre: String = ""
    var imagen: UIImage? = nil
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameApp.text! = nombre
        imageApp.image = imagen
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
}
