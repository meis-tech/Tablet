//
//  beacon.swift
//  BeaconFinderiPhone
//
//  Created by Alex Flohr on 9/27/15.
//  Copyright © 2015 Alex Flohr. All rights reserved.
//
//
import Foundation
//
class beacon {
    let major : String?
    let minor : NSNumber
    var ID : String?
    var first_name : String?
    var last_name : String?
    var DOB : String?
    var allergies : String?
    var blood_type : String?
    var chronic : String?
    var medication : String?
    var organ_donor : String?
    var image_name : String?
    var secure_url : String?
    
    convenience init(major : String) {
        print("in init");
        print(major);
        let returnmajor: Int? = Int(major)
//        var returnmajor : NSNumber = major.intValue;
        self.init( minor: 0, major:returnmajor!)
    }
    
    init(minor : NSNumber, major : NSNumber) {
        self.minor = minor
        self.major = major.stringValue;
        print(self.major);
        print(self.minor);
        print(self.major);
//        self.ID = "0000000000000000"
        print("In the initializer")
//        let urlString = NSString(format: "http://128.61.42.33:3000/personal_health_records/give_health_record?id=%s", major)
        var urlString = "https://fathomless-inlet-3449.herokuapp.com";
        urlString += "/personal_health_records/give_health_record?id=";
        urlString += self.major!;
        let url = NSURL(string : urlString as String)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        print(urlString)
        HTTPGet(urlString as String) {
            (data: String, error: String?) -> Void in
            if error != nil {
                print(error)
            } else {
                print("data is : \n\n\n")
                print(data)
                var Encodeddata: NSData = data.dataUsingEncoding(NSUTF8StringEncoding)!
                var jsonError: NSError?
                let jsonObject: AnyObject?
                do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(Encodeddata, options: NSJSONReadingOptions()) as? NSDictionary
                    print("in pass")
                    print(jsonObject)
                    if let id = (jsonObject as! NSDictionary)["id"] as! String? {
                        self.ID = id
                    }
                    if let first_name = (jsonObject as! NSDictionary)["first_name"] as! String? {
                        self.first_name = first_name
                    }
                    if let last_name = (jsonObject as! NSDictionary)["last_name"] as! String? {
                        self.last_name  = last_name
                    }
                    if let DOB = (jsonObject as! NSDictionary)["DOB"] as! String? {
                        self.DOB = DOB
                    }
                
                    if let allergies = (jsonObject as! NSDictionary)["allergies"] as! String? {
                        self.allergies = allergies
                    }
                    
                    if let chronic = (jsonObject as! NSDictionary)["chronic_disease"] as! String? {
                        self.chronic = chronic
                    }
                    
                    if let medication = (jsonObject as! NSDictionary)["medication"] as! String? {
                        self.medication = medication
                    }
                    
                    if let donor = (jsonObject as! NSDictionary)["organ_donor"] as! String? {
                        self.organ_donor = donor
                    }
                    if let donor = (jsonObject as! NSDictionary)["image_name"] as! String? {
                        self.image_name = donor
                    }
                    if let donor = (jsonObject as! NSDictionary)["secure_url"] as! String? {
                        self.secure_url = donor
                    }
                } catch let error as NSError {
                    print("in error")
                    print(error)
                }

            }
        }
        sleep(3)
    }
    
    func HTTPsendRequest(request: NSMutableURLRequest,callback: (String, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler :
            {
                    data, response, error in
                    if error != nil {
                        print("2")
                        callback("", (error!.localizedDescription) as String)
                    } else {
                        callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String,nil)
                    }
            })
            
            task.resume() //Tasks are called with .resume()
            
        }
        
    func HTTPGet(url: String, callback: (String, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!) //To get the URL of the receiver , var URL: NSURL? is used
        print("1")
        HTTPsendRequest(request, callback: callback)
    }
}