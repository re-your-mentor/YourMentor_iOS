//
//  Service.swift
//  YourMentor
//
//  Created by 이다경 on 1/30/25.
//

import Foundation
import Alamofire
import UIKit

class Service {
    
    static let shared = Service()
    private init() {}
    
    func uploadimage(_ image: UIImage, completion: @escaping (NetworkResult<String>) -> Void) {
        let url = APIConstants.imguploadURL
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]

        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: "image.jpg",
                                         mimeType: "image/jpeg")
            }
        }, to: url, headers: header)
        .responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    completion(.pathErr)
                    return
                }

                if (200...299).contains(statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(ImageUploadResponse.self, from: data)
                        if decodedData.success {
                            completion(.success(decodedData.img))
                        } else {
                            completion(.requestErr("이미지 업로드 실패"))
                        }
                    } catch {
                        completion(.pathErr)
                    }
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let decodedError = try decoder.decode(ErrorResponse.self, from: data)
                        completion(.requestErr(decodedError.message))
                    } catch {
                        completion(.pathErr)
                    }
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }

}
