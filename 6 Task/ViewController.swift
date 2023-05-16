//
//  ViewController.swift
//  6 Task
//
//  Created by Руслан Гайфуллин on 16.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var collision: UICollisionBehavior!
    private var animator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!

    private lazy var rectangleView: UIView = {
       let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    private lazy var gradient: CAGradientLayer = {
       let gradient = CAGradientLayer()
        gradient.frame = rectangleView.bounds
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 10
        return gradient
    }()
    
    override func viewWillLayoutSubviews() {
        rectangleView.layer.addSublayer(gradient)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .systemBackground
        view.addSubview(rectangleView)
        setupGesture()
        animator = UIDynamicAnimator(referenceView: view)

    }
    
    
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        animateRectangle(sender.location(in: self.view))
    }
    
    private func animateRectangle(_ point: CGPoint) {
        animator.removeAllBehaviors()
        
        collision = UICollisionBehavior(items: [rectangleView])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: rectangleView, snapTo: point)
        snapBehavior.damping = 0.9
        animator.addBehavior(snapBehavior)
        rectangleView.center = point
   
    }
   

}
