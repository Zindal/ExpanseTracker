//
//  ListExpanseVC.swift
//  ExpanseTracker
//
//  Created by Zindal on 12/01/21.
//

import UIKit
import CoreData

class ListExpanseVC: UIViewController {

    @IBOutlet var tblView: UITableView!
    var itemList: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView.init(frame: .zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Expanse List"
        itemList = CoreDataManager.shared.fetch()
        tblView.reloadData()
    }
    
    @IBAction func btnAddCLicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddExpanseVC") as! AddExpanseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListExpanseVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableCell") as! ItemListTableCell
        let manage = itemList[indexPath.row]
        cell.lblItemName.text = manage.value(forKeyPath: "title") as? String
        cell.lblAmount.text = manage.value(forKeyPath: "amount") as? String
        return cell
    }
}
