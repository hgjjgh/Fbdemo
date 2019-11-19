//
//  ViewController.swift
//  Fbdemo
//
//  Created by 黃國展 on 2019/11/19.
//  Copyright © 2019 黃國展. All rights reserved.
//

import UIKit
import FacebookCore


class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func fetchImage(url: URL?, completionHandler: @escaping (UIImage?) -> ()) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    completionHandler(image)
                } else {
                    completionHandler(nil)
                }
            }
            task.resume()
        }
    }
    
     override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            if let _ = AccessToken.current {
                Profile.loadCurrentProfile { (profile, error) in
                    if let profile = profile {
                        self.label.text = profile.name
                        let url = profile.imageURL(forMode: .square, size: CGSize(width: 300, height: 300))
                        
                        self.fetchImage(url: url) { (image) in
                            DispatchQueue.main.async {
                                self.image.image = image

                            }
                        }
                    }
                }
            }
        }


    }
