//
//  AddressCell.swift
//  bonizfood
//
//  Created by sina salehifard on 8/23/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var labelAddrss: UILabel!
    @IBOutlet weak var labelTell: UILabel!
    @IBOutlet weak var labelZipCode: UILabel!


    
    
    var id:Int!
    var index:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onTapEdit(_ sender: Any) {
        let address = AppDelegate.address[index]
        
        let vc = AppDelegate.curentViewController?.storyboard?.instantiateViewController(withIdentifier: "VCUpdateAddress") as! ViewControllerUpdateAddress
        vc.id = address.id
        vc.sharedZipCode = address.zip_code
        vc.sharedTell = address.tell
        vc.sharedAddress = address.address
        AppDelegate.curentViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onTapDelete(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "حذف آدرس", message: "این آدرس حذف شود ؟", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "بله", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.removeAddress()
        }))
        alert.addAction(UIAlertAction(title: "خیر", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        AppDelegate.curentViewController?.present(alert, animated: true, completion: nil)
        
    }
    func removeAddress(){
        let url = URL(string: AppConfig.URL_REMOVE_ADDRESS)
        let session = URLSession.shared
        
        let dictionray =  [
            "tell" : AppDelegate.tell,
            "pass" : AppDelegate.pass,
            "address_id" : id
            ] as [String : Any]
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
                        (AppDelegate.curentViewController as! onRefresh).onRefresh()
                        
                        
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
}
