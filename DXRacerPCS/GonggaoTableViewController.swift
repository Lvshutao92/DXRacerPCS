//
//  GonggaoTableViewController.swift
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/31.
//  Copyright © 2017年 ilovedxracer. All rights reserved.


import UIKit



class GonggaoTableViewController: UITableViewController {

    let 数据源数组:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
//        lodView()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.数据源数组.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = self.数据源数组.object(at: indexPath.row)
        cell.textLabel?.text = (model as AnyObject).ann_theme
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = self.数据源数组.object(at: indexPath.row)
//        let gonggao = FourViewController()
//        gonggao.html = (model as AnyObject).ann_content
//        let na = MainNavigationViewController(rootViewController: gonggao)
//        gonggao.navigationItem.title = "公告详情"
//        self.present(na, animated: true, completion: nil)
    }
    
    func lodView()  {
        var paramDic = [String: Any]()
        paramDic = ["business_id":"10001","page":1]
        paramDic = SwiftManager.returndiction(paramDic) as! [String : String]
        NetworkManager.shared.request(requestType: .POST, urlString: "https://dms.dxracer.com.cn/app/announce/getAnnCenterList", parameters: paramDic as [String : AnyObject]) { (json) in
            let 🌧️:NSDictionary = json!.object(forKey: "rows") as! NSDictionary
            let 🔥:NSArray = 🌧️.object(forKey: "resultList") as! NSArray
            self.数据源数组.removeAllObjects()
            for 字典 in 🔥 {
                let 数据模型:GGModel = GGModel.mj_object(withKeyValues: 字典)
                self.数据源数组.add(数据模型)
            }
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
    }
    
    
    
    
    
}




class GGModel: NSObject {
    var ann_content: String!
    var ann_status: String!
    var ann_theme: String!
    var business_id: String!
    var createtime: String!
    var id: String!
    var isindexsee: String!

    
    
//    override static func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
//        if var propertyName:String = "mymoney" {
//            propertyName = "new_money"
//        }
//        return propertyName
//    }
}
    



    
    
    
    
    
    
    
    

