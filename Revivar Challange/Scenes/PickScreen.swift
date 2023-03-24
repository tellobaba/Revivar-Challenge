//
//  PickScreen.swift
//  Revivar Challenge
//
//  Created by Oluwatomiwa on 22/03/2023.
//

import UIKit

class PickScreen: UIViewController {
    var imageArray: [UIImageView] = []
    
    let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    let imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        stackView.addArrangedSubview(imageView1)
        stackView.addArrangedSubview(imageView2)
        stackView.addArrangedSubview(imageView3)
        stackView.addArrangedSubview(imageView4)
        getRandomPhoto()
        setupView()
        setupTap()
    }
    
    func setupTap(){
        let subViews = stackView.arrangedSubviews
        for subView in subViews {
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(handleTap(_:)))
            subView.isUserInteractionEnabled = true
            subView.addGestureRecognizer(tapGesture)
        }
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer
    ){
        if let tapppedView = gesture.view, let index = stackView.arrangedSubviews.firstIndex(of: tapppedView){
            print("tapped view at index\(index)")
            displayModal(image: imageArray[index].image ?? UIImage())
        }
    }
    
    func displayModal(image:UIImage){
       let vc = ModalViewController()
        vc.imageView.image = image
        self.present(vc, animated: true)
    }
    
    func getRandomPhoto(){
            imageArray = [
            imageView1,
            imageView2,
            imageView3,
            imageView4
        ]
        let url = URL(string: "https://source.unsplash.com/random/300x300")!

        for index in 1...4 {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                print(data, "anjfhbdkjnvbe", index)
                DispatchQueue.main.async {
                    self.imageArray[index - 1].image = UIImage(data: data!)
                }
            }
            task.resume()
        }
        }
    
    func getRandomPhotoData(_ completion: @escaping (_ data: Data?) -> Void) {
        let urlString = "https://source.unsplash.com/random/300x300"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                completion(data)
            }.resume()
        }
    }
}

extension PickScreen {
    
    func setupView(){
        prepareView()
        prepareConstraints()
    }
    
    func prepareView(){
        view.addSubview(
            [
                stackView
            ]
        )
    }
    
    func prepareConstraints(){
        stackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
}
