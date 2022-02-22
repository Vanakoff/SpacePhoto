//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Andrey Vanakoff on 22/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = " "
        copyrightLabel.text = " "
        
        photoInfoController.fetchPhotoInfo { photoInfo in
            if let photoInfo = photoInfo {
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.descriptionLabel.text = photoInfo.description
                    
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                }
            }
        }

        
        func updateUI(with photoInfo: PhotoInfo) {
            let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: { data, response, error in
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.title = photoInfo.title
                        self.imageView.image = image
                        self.descriptionLabel.text = photoInfo.description
                        if let copyright = photoInfo.copyright {
                            self.copyrightLabel.text = "Copyright \(copyright)"
                        } else {
                            self.copyrightLabel.isHidden = true
                        }
                    }
                }
            })
            task.resume()
        }
    
  
    }

}

