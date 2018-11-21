//
//  ViewController.swift
//  AFStarter
//
//  Created by parrot on 2018-11-13.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBAction func getButtonPressed(_ sender: Any) {
        
        let URL = "https://api.darksky.net/forecast/ab7e37126fbeddc41405bc6e414058fe/43.6532,-79.3832?units=ca"
        
        // ALAMOFIRE function: get the data from the website
        Alamofire.request(URL, method: .get, parameters: nil).responseJSON {
            (response) in
            
            // -- put your code below this line
            
            if (response.result.isSuccess) {
                print("awesome, i got a response from the website!")
                print("Response from webiste: " )
                print(response.data)
                
                do {
                    let json = try JSON(data:response.data!)
                    
                    //print(json)
                
                    // PARSING: grab the latitude and longitude
                    print(json["latitude"])
                    print(json["longitude"])
                    
                    print("------")
                    
                    // EXAMPLE:  Get the temperature
                    
                    //OPTIOAL: You could write the code like this:
                    // let currently = json["currently"]
                    // let temp = currently["temperature"]
                    
                    // or, you could write it like this (in one line)
                    let temp = json["currently"]["temperature"]
                    
                    print("Temperature in C: \(temp)")
                
                    // EXAMPLE: Manually Convert temperature to farenheit
                    let c = json["currently"]["temperature"].double!
                    let f = (c * 9/5)+32
                    
                    print("Temp in F: \(f)")
                    
                    print("------")
                    
                    
                    // EXAMPLE: Get an array inside a dictionary
                    // (Flags > sources)
                    // If you look at the JSON output, you can tell that flags > sources
                    // is an ARRAY OF STRINGS!
                    
                    // FORCE flags>sources to become an ARRAY
                    let flags = json["flags"]["sources"].array!
                    
                    
                    // OPTION 1: Use a foreach loop to iterate through the
                    // array.  This will output:
                    // nearest precip, ecpa, cnc, gfs, hrrr, icon... etc...
                    for x in flags {
                        print(x)
                    }

                    print("-----")
                    // OPTION 2: Get a specific item in the array.
                    // Code below will outbout "nearest-recip", "ecpa", "hrrr"
                    print("One item in flags array: \(flags[0])")
                    print(flags[1])
                    print(flags[4])
                    
                    
                    // EXAMPLE:  Get a array of dictionaries
                    // (daily > data)
                    // This is an array of dictionaries!
                    // Each item in the array shows weather information for a specific day.
                    
                    // Force dailyData to be an ARRAY!
                    let dailyData = json["daily"]["data"].array!;
                    //print(dailyData)
                    
                    print("-------")
                    print("-------")
                    print("-------")
                    
                    
                    // EXAMPLE: get a single key out of an array of dictionaries
                    // For example, get the sunrise time for the next 7 days
                    // Information is in daily > data > sunriseTime
                    
                    // OPTION 1: Get the weather for day 1 and show it
                    let day1 = dailyData[0]
                    let day2 = dailyData[1]
                    let day3 = dailyData[2]
                    
                    print("Sunrise on day 1 is at: \(day1["sunriseTime"])")
                    print("Sunrise on day 2 is at: \(day2["sunriseTime"])")
                    print("Sunrise on day 3 is at: \(day3["sunriseTime"])")
                    print("------")

                    // OPTION 2: Auomatically loop through the data
                    
                    for m in dailyData {
                        // dailyData is an ARRAY OF DICTIONARIES
                        // m is ONE ITEM in the ARRAY
                        // m has a key called SUNRISE TIME
                        print("The sun rises at: \(m["sunriseTime"])")
                    }
                    
                    
                   
                    
                    
                }
                catch {
                    print ("Error while parsing JSON response")
                }
                
            }
            
        }
        
       
        
        
        // SWIFT: do somethign with the data
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.flatGreenDark
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

