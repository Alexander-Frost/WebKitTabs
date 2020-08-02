//
//  ContainerView.swift
//  WebKitTabs
//
//  Created by Alex on 8/2/20.
//  Copyright © 2020 Weekend. All rights reserved.
//

import UIKit

class ContainerView: UIView, UIGestureRecognizerDelegate { // Contains the webview for each tab

    // MARK: - Properties
    
    private var savedOriginY: CGFloat = 0.0
    private var parentView: SwitcherView
    private var isFullScreen: Bool = false
    private var savedTransform: CATransform3D = CATransform3DIdentity
    private var tapRecognizer: UITapGestureRecognizer!
    
    // MARK: - Public
    
    public var index: Int = 0
    
    // MARK: - Init

    // Convenience initializer that sets up a web view.
    convenience init(frame: CGRect, parentView: SwitcherView, urlString: String) {
        self.init(frame: frame, parentView: parentView)
        let webSubview = UIWebView(frame: bounds)
        webSubview.isUserInteractionEnabled = SwitcherView.enableUserInteractionInSwitcher
        addSubview(webSubview)
        if let url = URL(string: urlString) {
            webSubview.loadRequest(URLRequest(url: url))
        } else {
            fatalError("<!> could not create url with string: `\(urlString)`")
        }
    }

    // Convenience initializer that sets takes a custom view as argument.
    convenience init(frame: CGRect, parentView: SwitcherView, customView: UIView) {
        self.init(frame: frame, parentView: parentView)
        customView.isUserInteractionEnabled = SwitcherView.enableUserInteractionInSwitcher
        addSubview(customView)
    }

    // Convenience initializer that sets an image as the layer's contents.
    convenience init(frame: CGRect, parentView: SwitcherView, imageName: String) {
        self.init(frame: frame, parentView: parentView)
        self.layer.contents = UIImage(named: "addfriends")!.cgImage!
    }

    init(frame: CGRect, parentView: SwitcherView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.parentView = parentView
        savedOriginY = frame.origin.y
        
        // Create and initialize a tap gesture
        tapRecognizer = UITapGestureRecognizer(target:self, action:#selector(toggleAnimation))
        // Specify that the gesture must be a single tap
        tapRecognizer.numberOfTapsRequired = 1
        
        // Add the tap gesture recognizer to the view
        addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        
        // Add a shadow to the cards
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 20.0
        
        // enable anti-aliasing
        layer.edgeAntialiasingMask = CAEdgeAntialiasingMask(rawValue:
            CAEdgeAntialiasingMask.layerLeftEdge.rawValue |
                CAEdgeAntialiasingMask.layerRightEdge.rawValue |
                CAEdgeAntialiasingMask.layerBottomEdge.rawValue |
                CAEdgeAntialiasingMask.layerTopEdge.rawValue)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    
    // Instruct that the tap recognizer is allowed to work in conjunction with vanilla UIView recognizers.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // Called by the tap gesture recognizer. Ushers the parent view's toggle between the switcher and full screen modes.
    @objc func toggleAnimation() {
        isFullScreen = !isFullScreen
        parentView.animate(view: self, isFullScreen: isFullScreen)
        parentView.scrollView.isScrollEnabled = !isFullScreen
        // if user interaction should be disable in switcher mode, update that now
        if !SwitcherView.enableUserInteractionInSwitcher {
            for subview in subviews {
                subview.isUserInteractionEnabled = isFullScreen
            }
        }
    }
}
