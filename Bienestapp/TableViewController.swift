//
//  TableViewController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Alamofire
import UIKit
import AlamofireImage

var table = tableCell()

class TableViewController: UITableViewController {
    
    var json: [[String:Any]]?
    var jsonUse:[[String:Any]]?
    
    var numberJson = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        getUsages()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberJson
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! tableCell
        
        if json != nil {
            let url = URL(string: json![indexPath.row]["icon"] as! String)
            cell.nameApp.text = (json![indexPath.row]["name"]! as! String)
            cell.imageApp.af_setImage(withURL: url!)
        }
        
        if jsonUse != nil {
            cell.timeApp.text = (jsonUse![indexPath.row]["totalTime"]! as! String)
            cell.dateApp.text = (jsonUse![indexPath.row]["day"]! as! String)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! showAppController
        let cell = sender as! tableCell
        let nombre = cell.nameApp.text!
        let imagen = cell.imageApp.image!
        let time = cell.timeApp.text!
        let date = cell.dateApp.text!
        nextScreen.nombre = nombre
        nextScreen.imagen = imagen
        nextScreen.time = time
        nextScreen.date = date
    }
    
    
    
    func getUser() {
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/mostrar")
        
        let header = ["Authorization": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [[String: Any]]
                self.numberJson = self.json!.count
                self.tableView.reloadData()
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
    
    func getUsages() {
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/mostrarUso")
        
        let header = ["Authorization": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
               self.jsonUse = response.result.value as! [[String: Any]]
               self.tableView.reloadData()
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
