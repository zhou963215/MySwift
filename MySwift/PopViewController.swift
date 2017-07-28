//
//  PopViewController.swift
//  MySwift
//
//  Created by zhou on 2017/6/24.
//  Copyright © 2017年 zhou. All rights reserved.
//

import UIKit
import Alamofire

class PopViewController: UIViewController {

    fileprivate lazy var  tableView : UITableView = {
    
        let table  = UITableView(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        
        
        
        
    return table
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        view .addSubview(self.tableView)
        jsonRequest()
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    
    }
    
    func jsonRequest()  {
        let parameters = ["foo": "bar","baz": ["a", 1],"qux": ["x": 1,"y": 2,"z": 3]] as [String : Any]
        
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
//        Alamofire.request(.POST, "https://httpbin.org/post", parameters: parameters)
//            .responseJSON { (response) in
//                print("jsonRequest:\(response.result)")
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
        let requestHeader:HTTPHeaders = ["Range":"1-3"];

//        let httpMethod = HTTPMethod(rawValue: "post")
     
         Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: URLEncoding.default, headers:requestHeader ).responseJSON { (response) in
        
//          let statusCode =  response.response?.statusCode
            
            if response.result.isSuccess{
                
                print(response.result.value!)
                
                
                
            }
            
//            print(response)
            
        }
        
        
        
    
        
    }
 
}

extension PopViewController : UITableViewDelegate , UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var  cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = String(indexPath.row)
        
        let str = "12312"
        
        let index = Int(str)
        
        print(index!)
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        print(indexPath.row)
        
    }
    
    
    
}

