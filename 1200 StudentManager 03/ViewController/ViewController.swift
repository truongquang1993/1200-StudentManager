//
//  ViewController.swift
//  1200 StudentManager 03
//
//  Created by Trương Quang on 7/6/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outletTableView: UITableView!
    var listStudent = [InforStudent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outletTableView.dataSource = self
        outletTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        outletTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        let inforStudent = listStudent[indexPath.row]
        cell.inforStudent = inforStudent
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc2 = segue.destination as? UINavigationController{
            if let vc3 = vc2.topViewController as? MyViewController{
                vc3.delegate = self
                if let indexPath = outletTableView.indexPathForSelectedRow {
                    vc3.inforStudent = listStudent[indexPath.row]
                }
            }
        }
    }
}

extension ViewController: addInforStudentToList{
    func addInforStudentToListDelegate(with data: InforStudent) {
        if let indexPath = outletTableView.indexPathForSelectedRow {
            listStudent[indexPath.row] = data
        } else {
            listStudent.append(data)
        }
        outletTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
