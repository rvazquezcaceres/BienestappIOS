//
//  TableViewController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

var table = tableCell()

class TableViewController: UITableViewController {

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! tableCell
        cell.imageApp.image = #imageLiteral(resourceName: "kyrgios")
        return cell
    }
    
}
