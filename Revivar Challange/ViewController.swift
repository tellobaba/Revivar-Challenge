//
//  ViewController.swift
//  Revivar Challenge
//
//  Created by Oluwatomiwa on 22/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let selectButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        title = "Start"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setUpButton() {
        view.addSubview(selectButton)
        
        selectButton.configuration = .filled()
        selectButton.configuration?.baseBackgroundColor = .black
        selectButton.configuration?.title = "Start"
        
        selectButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: 200),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func goToNextScreen(){
        let nextScreen = PickScreen()
        nextScreen.title = "Select an Image"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

