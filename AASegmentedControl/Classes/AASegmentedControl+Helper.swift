//
//  AASegmentedControl+Helper.swift
//  Pods
//
//  Created by Engr. Ahsan Ali on 01/02/2017.
//  Copyright (c) 2017 AA-Creations. All rights reserved.
//


// MARK: - Autolayout handling and frame calculation
extension AASegmentedControl {
    
    var itemFrame: CGRect {
        get {
            let totalItems = CGFloat(itemNames.count)
            var frame = self.bounds
            
            if isHorizontal {
                frame.size.width /= totalItems
            }
            else {
                frame.size.height /= totalItems
            }
            
            return frame
        }
    }
    
    
    /// Auto Layout constraints for labels
    ///
    /// - Parameters:
    ///   - bindAttrs: Attributes for binding views
    ///   - preAttr: Attribute before the view
    ///   - nextAttr: Attribute after the view
    ///   - equalAttr: Attribute equal to the view
    func layoutItems(bindAttrs: [NSLayoutAttribute], preAttr: NSLayoutAttribute, nextAttr: NSLayoutAttribute, equalAttr: NSLayoutAttribute) {
        
        let constraints = items.enumerated().flatMap { (index, label) -> [NSLayoutConstraint] in
            var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
            
            /// Constraints to bind the views
            let bindConstraints = bindAttrs.flatMap({ (attr) -> NSLayoutConstraint in
                return NSLayoutConstraint(item: label, attribute: attr, relatedBy: .equal, toItem: self, attribute: attr, multiplier: 1.0, constant: 0)
            })
            
            constraints.append(contentsOf: bindConstraints)
            
            /// Constraint after the view
            var nextConstraint : NSLayoutConstraint {
                
                guard index != items.count - 1 else {
                    return NSLayoutConstraint(item: label, attribute: nextAttr, relatedBy: .equal, toItem: self, attribute: nextAttr, multiplier: 1.0, constant: 0)
                }
                let nextItem = items[index+1]
                return NSLayoutConstraint(item: label, attribute: nextAttr, relatedBy: .equal, toItem: nextItem, attribute: preAttr, multiplier: 1.0, constant: 0)
            }
            
            constraints.append(nextConstraint)
            
            /// Constraint before the view
            var preConstraint : NSLayoutConstraint {
                
                guard index != 0 else {
                    
                    return NSLayoutConstraint(item: label, attribute: preAttr, relatedBy: .equal, toItem: self, attribute: preAttr, multiplier: 1.0, constant: 0)
                }
                
                /// Constraint equal the first view
                let equalConstraint = NSLayoutConstraint(item: label, attribute: equalAttr, relatedBy: .equal, toItem: items.first!, attribute: equalAttr, multiplier: 1.0, constant: 0)
                
                constraints.append(equalConstraint)
                
                let prevItem = items[index-1]
                return NSLayoutConstraint(item: label, attribute: preAttr, relatedBy: .equal, toItem: prevItem, attribute: nextAttr, multiplier: 1.0, constant: 0)
                
            }
            
            constraints.append(preConstraint)
            
            return constraints
        }
        
        self.addConstraints(constraints)
    }
    
    
}
