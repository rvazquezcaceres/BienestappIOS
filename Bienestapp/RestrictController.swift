//
//  RestrictController.swift
//  Bienestapp
//
//  Created by alumnos on 05/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class RestrictController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var json: [[String:Any]]?
    var numberJson = 0
    var SelectApp = ""
    
    
    
    var restriction = Restriction()

    @IBOutlet weak var textAdd: UILabel!
    @IBOutlet weak var sliderRestrict: UISlider!
    @IBOutlet weak var textSlider: UILabel!
    @IBOutlet weak var pickerStart: UIDatePicker!
    @IBOutlet weak var pickerEnd: UIDatePicker!
    @IBOutlet weak var pickApp: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickApp.delegate = self
        self.pickApp.dataSource = self
        getApps()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberJson
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SelectApp = json![row]["name"]! as! String
        return SelectApp
    }
    
    
    @IBAction func addRestrict(_ sender: Any) {
        let valueSlider = self.sliderRestrict!.value as Float
        let integer: Int = Int(valueSlider)
        
        restriction.name = SelectApp
        restriction.max_time = String(integer)
        
        let start = pickerStart.date
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let startText = formateador.string(from: start)
        
        var finish = pickerEnd.date
        finish = checkDate(pickerStart: start, pickerEnd: finish)
        let finishText = formateador.string(from: finish)
        
        restriction.start_hour = startText
        restriction.finish_hour = finishText
        
        postRestriction(restriction: restriction)
    }
    
    @IBAction func sliderInfo(_ sender: Any) {
        self.textSlider.text = "\(self.sliderRestrict.value)"
    }
    
    func checkDate(pickerStart:Date, pickerEnd: Date) -> Date {
        if pickerStart >= pickerEnd {
            let newFinish = pickerEnd + 86400
            return newFinish
        }
        return pickerEnd
    }
    
    func postRestriction(restriction: Restriction){
        let url = URL(string: "http://localhost:8888/Ruben/Bienestapp/public/index.php/api/restrict")
        
        let header = ["Authorization": token]
        
        let json = ["name": restriction.name, "max_time": restriction.max_time, "start_hour_restriction": restriction.start_hour, "finish_hour_restriction": restriction.finish_hour] as [String: Any]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print("Ruben", response.response!.statusCode)
        }
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
    
}
