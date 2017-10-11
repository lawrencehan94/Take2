//
//  ViewController.swift
//  Fin Wiz
//
//  Created by Lawrence Han on 10/6/17.
//  Copyright © 2017 Lawrence Han. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var multipleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var companies = [Company]()
    
    let identifier = "GOOGL"
    let item = "evtonextyearrevenue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func getDataButtonPrssed(_ sender: UIButton) {
        getData()
        tableView.reloadData()
        print(companies)
    }
    
    func updateData(json: [String: Any]) {
        if let result = json["value"], let ticker = json["identifier"] {
            DispatchQueue.main.async {
                let newCompany = Company()
                newCompany.ticker = "\(ticker)"
                newCompany.value = "\(result)"
                self.companies.append(newCompany)
            }
        } else {
            print("Failure")
        }
    }

    func getData() {
        let userPasswordString = "babf6dca6f14d9dd9d5d9cefbb74cb23:e1fd3e208302dff589f3748c88b0f6f3"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
        let authString = "Basic \(base64EncodedCredential)"
        
        let config = URLSessionConfiguration.default // Session Configuration
        
        config.httpAdditionalHeaders = ["Authorization": authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "https://api.intrinio.com/data_point?identifier=\(identifier)&item=\(item)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        //Implement your logic
                        self.updateData(json: json)
                    }
                }
                catch {
                    print("error in JSONSerialization")
                }
            }
        })
        
        task.resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as? CompanyCell else { return UITableViewCell() }
        return cell
    }
}

// Internet company tickers: GOOGL, FB, SEHK:700, BIDU, SNAP, TWTR, IAC, TRIP, AMZN, BABA, PCLN, NFLX, JD, PYPL, EBAY, CTRP, EXPE, TSE:4755, XTRA:ZAL, VIPS, AIM:ASC, ZG, SQ, LSE:JE, GDDY, W, TRVG, GRUB, TSE:3938, ENXTAM: TKWY, AAPL, YELP

