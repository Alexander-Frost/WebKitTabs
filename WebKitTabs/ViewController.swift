//
//  ViewController.swift
//  WebKitTabs
//
//  Created by Alex on 8/2/20.
//  Copyright © 2020 Weekend. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    private let tabView = SwitcherView(frame: UIScreen.main.bounds)
    
    // MARK: - Actions
    
    @objc func newTabBtnPressed(sender: UIButton){
        print("New tab button pressed")
        
        //tabView.addContainerView(ContainerView(frame: tabView.bounds, parentView: tabView, imageName: "image3.jpg"))
        tabView.addContainerView(ContainerView(frame: tabView.bounds, parentView: tabView, urlString: "https://www.google.com/search?q=alex+rulez"))
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI(){
        // Add tab view
        view.addSubview(tabView)

        // Remove Tab View
//        for view in self.view.subviews {
//            if view.isKind(of: SwitcherView.self) {
//                view.removeFromSuperview()
//            }
//        }
        
        // New Tab Button
        let frame = CGRect(x: 200, y: UIScreen.main.bounds.height - 100, width: 100, height: 100)
        let newTabBtn = UIButton(frame: frame)
        newTabBtn.backgroundColor = .blue
        newTabBtn.setTitle("NEW TAB", for: .normal)
        newTabBtn.setTitleColor(.white, for: .normal)
        newTabBtn.addTarget(self, action: #selector(newTabBtnPressed(sender:)), for: .touchDown)
        newTabBtn.sizeToFit()
        view.addSubview(newTabBtn)
    }
}

