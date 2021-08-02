//
//  PriceManager.swift
//  BitcoinTracker
//
//  Created by Shivansh on 10/12/20.
//

import Foundation
import UIKit
protocol finishedFetching {
    func finished(_ data:ReturnInfo)
}
struct PriceManager {
    var delegate:ViewController?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "19167388-619D-4C69-AA80-38370FB654CA"
    let currencyArray = ["Select-Currency","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func getPrice(_ row:Int){
        let add="\(baseURL)/\(currencyArray[row])?apikey=\(apiKey)"
//        print(add)
        let url=URL(string: add)
        let session = URLSession(configuration: .default)
        let task=session.dataTask(with: url!) { (data, response, error) in
            let decoder=JSONDecoder()
            do{
                if let safeData=data{
                    let decodedData=try(decoder.decode(ReturnInfo.self, from: safeData))
                    delegate?.finished(decodedData)
//                    print("TEST")
            }
        
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
       
}
