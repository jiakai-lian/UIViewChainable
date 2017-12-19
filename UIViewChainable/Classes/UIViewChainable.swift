//
//  UIViewChainable.swift
//
//  Created by Jacky Lian on 21/11/17.
//

import UIKit

public protocol UIViewChainable {}
public extension UIViewChainable where Self: UIView {
    @discardableResult
    public func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
    @discardableResult
    public func layout(_ layout: (Self) -> Void) -> Self {
        layout(self)
        return self
    }
    
    
    //Automatically turn off the auto sizing flag
    @discardableResult
    public func constraintLayout(_ layout: (Self) -> Void) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self.layout(layout)
    }
    
    //Activate all the constraints
    //You should only call this method when all the constraints are programatically added and should be all activated
    //Do not use this method if you have conditional constraints
    @discardableResult
    public func activateAllConstraints() -> Self {
        return activate(constraints)
    }
    
    @discardableResult
    public func activate(_ constraints:[NSLayoutConstraint]) -> Self {
        constraints.forEach {
            $0.activate()
        }
        
        return self
    }
    
    @discardableResult
    public func deactivateAllConstraints() -> Self {
        return deactivate(constraints)
    }
    
    @discardableResult
    public func deactivate(_ constraints:[NSLayoutConstraint]) -> Self {
        constraints.forEach {
            $0.deactivate()
        }
        
        return self
    }
}

extension UIView: UIViewChainable {
    @discardableResult
    public func attachTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}

extension NSLayoutConstraint {
    @discardableResult
    public func activate() -> Self{
        isActive = true
        
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self{
        isActive = false
        
        return self
    }
}
