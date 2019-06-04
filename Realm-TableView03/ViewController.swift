//
//  ViewController.swift
//  Realm-TableView03
//
//  Created by D7703_22 on 2019. 6. 4..
//  Copyright © 2019년 fb. All rights reserved.
//

import UIKit
import RealmSwift

//모델 정리
class Person: Object{
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    //DB에 있는 갑들과 동기화되는 특별한 형태의 리스트
    var personArray : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        
        //프로그램 시작시 DB에서 값을 읽어 Result에 저장
        let realm = try! Realm()
        personArray = realm.objects(Person.self)
    }
    
    @IBAction func addObject(_ sender: Any) {
        //새객체 만들기
        let newPerson = Person()
        newPerson.name = nameTextField.text!
        newPerson.age = Int(ageTextField.text!)!
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(newPerson)
        }
     
        nameTextField.text = ""
        ageTextField.text = ""
        
        myTableView.reloadData()
    }
    
    @IBAction func deleteObject(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        myTableView.reloadData();
    }
    @IBAction func getObject(_ sender: Any) {
        let realm = try! Realm()
        personArray = realm.objects(Person.self).filter("age > 10")
        print(personArray!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (personArray?.count)!
    }
    func tableView(_ tableView: UITableView,3 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        cell.textLabel?.text = personArray![indexPath.row].name
        cell.detailTextLabel?.text = String(personArray![indexPath.row].age)
        return cell
    }

}

