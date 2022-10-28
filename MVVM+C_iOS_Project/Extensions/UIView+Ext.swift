//
//  UIView+Ext.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit

enum Edge {
    case top, bottom, left, right
}

extension UIView {
    func pinToSuperviewEdges(_ edges: [Edge] = [.top, .bottom, .left, .right], constant: CGFloat = 0) {
        
        guard let superview = superview else { return }
        
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            }
        }
    }
}
