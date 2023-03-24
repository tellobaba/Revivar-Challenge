//
//  ModalViewController.swift
//  Revivar Challange
//
//  Created by Oluwatomiwa on 23/03/2023.
//

import UIKit
import Photos

class ModalViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    lazy var thankyouLabel: UILabel = {
        let label = UILabel()
        label.text = "Thank you!!!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 45.0)
        label.textColor = .white
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Write your name"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 45.0)
        label.textColor = .white
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        return textField
        
    }()
    
    let newButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        createNewButton()
        buttonAction()
        
    }
    
    func createNewButton(){
        newButton.frame = CGRect.init(x: self.view.frame.width/3.5, y: self.view.frame.height/2, width: 180, height: 50)
        newButton.setTitle("Download Image", for: .normal)
        newButton.setTitleColor(.white, for: .normal)
        newButton.backgroundColor = .black
        view.addSubview(newButton)
    }
    
    func buttonAction(){
        newButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender : AnyObject) {
        //        let imageData = UIImage().pngData()
        //        let compressedImage = UIImage(data: imageData!)
        //        UIImageWriteToSavedPhotosAlbum(compressedImage!,nil,nil, nil)
        //
        //        let alert = UIAlertController(title: "Saved", message: "Your Image has been saved", preferredStyle: .alert)
        //        let okAction = UIAlertAction(title: "Ok", style: .default)
        //        alert.addAction(okAction)
        //        self.present(alert, animated: true)
        let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
        let image = renderer.image { ctx in
            imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        DispatchQueue.global(qos: .userInitiated).async {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        print("Button Tapped")
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Handle error
            print("Error saving image to photo library: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            let sheet = UIAlertController(title: "Saved", message: "Your Image has been saved", preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Nice", style: .default,handler:nil))
            present(sheet, animated: true)
            
            print("Image saved to photo library")
        }
    }
}
            
            extension ModalViewController {
                func setupView(){
                    view.backgroundColor = .white
                    prepareView()
                    prepareConstraints()
                }
                
                func prepareView(){
                    view.addSubview([imageView, thankyouLabel, nameLabel, nameTextField])
                }
                
                func prepareConstraints(){
                    imageView.anchor(
                        top: view.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0
                    )
                    
                    thankyouLabel.anchor(top: view.topAnchor,
                                         left: view.leftAnchor,
                                         right: view.rightAnchor,
                                         paddingTop: 10,
                                         paddingLeft: 16,
                                         paddingRight: 16
                    )
                    nameLabel.anchor(
                        left: view.leftAnchor,
                        bottom: view.bottomAnchor,
                        right: view.rightAnchor,
                        paddingLeft: 16,
                        paddingBottom: 110,
                        paddingRight: 16
                    )
                    nameTextField.anchor(top: nameLabel.bottomAnchor,
                                         left: view.leftAnchor,
                                         bottom: view.bottomAnchor,
                                         right: view.rightAnchor,
                                         paddingTop: 5,
                                         paddingLeft: 16,
                                         paddingBottom: 5,
                                         paddingRight: 16
                    )
                }
            }
     
