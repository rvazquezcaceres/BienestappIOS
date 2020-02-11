//
//  StatsController.swift
//  Bienestapp
//
//  Created by alumnos on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class StatsController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var json: [[String:Any]]?
    var jsonUse:[[String:Any]]?
    var numberJson = 0
    var time: [String] = ["day", "week", "month"]
    
    @IBOutlet weak var pickApp: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApps()
        getUsages()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.pickApp.delegate = self
        self.pickApp.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return time[row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberJson
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! StatsCell
        
        if json != nil {
            let url = URL(string: json![indexPath.row]["icon"] as! String)
            cell.nameApp.text = (json![indexPath.row]["name"]! as! String)
            cell.imageApp.af_setImage(withURL: url!)
        }
        
        if jsonUse != nil {
            cell.timeApp.text = (jsonUse![indexPath.row]["totalTime"]! as! String)
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
    
    func getApps() {
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/mostrar")
        
        let header = ["Authorization": token]
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response.response!.statusCode)
            if response.response!.statusCode == 201 {
                self.json = response.result.value as! [[String: Any]]
                self.numberJson = self.json!.count
                self.pickApp.reloadAllComponents()
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
