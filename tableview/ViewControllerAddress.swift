//
//  ViewControllerAddress.swift
//  bonizfood
//
//  Created by sina salehifard on 8/23/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit
import TTGSnackbar
class ViewControllerAddress: UIViewController,UITableViewDelegate,UITableViewDataSource,onRefresh{
   
    @IBOutlet weak var tableViewAddress: UITableView!
    var isPay:Bool = true
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.curentViewController  = self
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        getAddress()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewAddress.separatorStyle = .none
        UINavigationBar.appearance().isTranslucent = false
        AppConfig.setFont(view: view)
    }

    @IBAction func onTapPlus(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCUpdateAddress") as! ViewControllerUpdateAddress
        vc.id = 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.address.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        let address = AppDelegate.address[indexPath.row]
        
        cell.labelAddrss.text  = "آدرس : \(address.address!)"
        cell.labelTell.text  = "شماره تماس : \(address.tell!)"
        cell.labelZipCode.text  = "کد پستی : \(address.zip_code!)"
        cell.id = address.id
        

        cell.index = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        AppConfig.setFont(view: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPay{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCPayment") as! ViewControllerPayment
            vc.position = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    
    private func getAddress(){
        AppDelegate.address.removeAll()
        let url = URL(string: AppConfig.URL_GET_ADDRESS)
        let session = URLSession.shared
        
        let dictionray =  [
            "tell" : AppDelegate.tell,
            "pass" : AppDelegate.pass
        ]
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: dictionray, options: JSONSerialization.WritingOptions(rawValue: 0))
            let request = NSMutableURLRequest(url: url!)
            request.httpBody = jsonData
            request.httpMethod = "POST"
            request.timeoutInterval = TimeInterval(60)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task =  session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard error == nil else {
                    print("sina msg: calling GET on /todos/1")
                    return
                }
                // make sure we got data
                guard data != nil else {
                    print("sina msg: did not receive data")
                    return
                }
                
                do{
                    guard let record = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else{
                        return
                    }
                    let myerror = record["error"] as! Bool
                    if !myerror{
                        
                        let records = record["address"] as! NSArray
                        for item in records{
                            let record =  item as! [String:Any]
                            let address = StructAddress()
                            address.id = Int(record["id"] as! String)
                            address.address = record["address"] as! String
                            address.tell = record["tell"] as! String
                            address.zip_code = record["zip_code"] as! String
                            AppDelegate.address.append(address)
                        }
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.tableViewAddress.reloadData();
                        })
                        
                        
                    }else{
                        print("sina error : \(String(describing: record["error_msg"]))")
                    }
                }catch let er{
                    print(er)
                }
                
            })
            
            
            task.resume()
        }catch{
            print("sina msg : error json writing")
        }
    }
    
    
    func onRefresh() {
        let snackbar = TTGSnackbar(message:  "آدرس مورد نظر حذف شد", duration: .middle)
        snackbar.backgroundColor = UIColor(hexString: "#e53935")
        snackbar.show()
        getAddress()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

}
