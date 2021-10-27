//
//  VisionManager.swift
//  ssacVision
//
//  Created by 강호성 on 2021/10/27.
//

import Foundation
import UIKit.UIImage
import Alamofire
import SwiftyJSON

class VisionAPIManager {
    
    static let shared = VisionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> ()) {
        let apikey = Bundle.main.apiKey
        let KAKAO = "\(apikey)"
        let visionURL = "https://dapi.kakao.com/v2/vision/face/detect"
        
        let header: HTTPHeaders = [
            "Authorization": KAKAO
            //"Content-Type": "multipart/form-data" -> AF에 내장이 되어있음
        ]
        
        // UIImage를 바이너리타입으로 변환
        guard let imageData = image.pngData() else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: visionURL, headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
