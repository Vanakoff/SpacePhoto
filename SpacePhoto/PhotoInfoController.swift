//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Andrey Vanakoff on 22/02/2022.
//

import UIKit

class PhotoInfoController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query: [String: String] = [
            "api_key": "62tCgwWXceqM1Tk7aGCeBb8RsAoIa9HeIDsckJwJ",
            "date": "2022-02-20"
        ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
             //   print(photoInfo)
                completion(photoInfo)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
            }
        }
        task.resume()
    }
    
//    func updateUI(with photoInfo: PhotoInfo) {
//        let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: { data, response, error in
//            if let data = data,
//               let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.title = photoInfo.title
//                    self.imageView.image = image
//                    self.descriptionLabel.text = photoInfo.description
//                    if let copyright = photoInfo.copyright {
//                        self.copyrightLabel.text = "Copyright \(copyright)"
//                    } else {
//                        self.copyrightLabel.isHidden = true
//                    }
//                }
//            }
//        })
//        task.resume()
//    }
    
    
}
