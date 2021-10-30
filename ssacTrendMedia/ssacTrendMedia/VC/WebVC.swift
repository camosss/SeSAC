//
//  WebVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/18.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class WebVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var webView: WKWebView!
    
    var navigationTitle = ""
    var mediaType = ""
    var id = 0

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationTitle
        
        fetchData()
    }
    
    // MARK: - Fetch Data
    
    func fetchData() {
        let appid = Bundle.main.tmDBApiKey
        let url = mediaType == "movie" ? "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(appid)&language=en-US" : "https://api.themoviedb.org/3/tv/\(id)/videos?api_key=\(appid)&language=en-US"
    
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let key = json["results"][0]["key"].stringValue
                
                DispatchQueue.main.async {
                    self.webView.load(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=\(key)")!))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
