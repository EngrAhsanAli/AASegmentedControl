//
//  AASegmentedControl.swift
//  AASegmentedControl
//
//  Created by Engr. Ahsan Ali on 01/10/2017.
//  Copyright (c) 2017 AA-Creations. All rights reserved.
//

import UIKit

@IBDesignable open class AASegmentedControl: UIControl {

    /// Item names
    open var itemNames: [String] = ["Tab 1", "Tab 2"]
    
    /// Font for items
    open var font: UIFont = UIFont.boldSystemFont(ofSize: 14)
    
    /// Selected Index
    open var selectedIndex : Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable Allow daming animation
    @IBInspectable open var allowDamping: Bool = false
    
    /// @IBInspectable Active underline bool
    @IBInspectable open var activeUnderline: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /// @IBInspectable AASegmentedControl direction
    @IBInspectable open var isHorizontal: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }

    /// @IBInspectable Border radius
    @IBInspectable open var borderRadius: CGFloat = 5 {
        didSet {
            let maxRadius = frame.height/2
            if borderRadius > maxRadius {
                borderRadius = maxRadius
            }
            setNeedsLayout()

        }
    }
    
    /// @IBInspectable border width
    @IBInspectable open var borderWidth: CGFloat = 2 {
        didSet {
            let maxWidth: CGFloat = 4
            if borderWidth > maxWidth {
                borderWidth = maxWidth
            }
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable Border color
    @IBInspectable open var borderColor : UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable active text color
    @IBInspectable open var activeColor : UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable unactive text color
    @IBInspectable open var unactiveColor : UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable active background color
    @IBInspectable open var activeBG: UIColor = .darkGray {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Items array for UILabel
    var items: [UILabel] = [UILabel]()
    
    /// Active background view
    var activeBackground: UIView = UIView() {
        didSet {
            activeBackground.frame = itemFrame
            activeBackground.backgroundColor = activeBG
            activeBackground.layer.cornerRadius = activeUnderline ? 0 : borderRadius
            insertSubview(activeBackground, at: 0)
        }
    }
    
    /// draw
    ///
    /// - Parameter rect: rect
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        activeBackground = UIView()

        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = borderRadius
        layer.borderWidth = borderWidth
        
        setupItems()
        setupAutoLayout()
        setNeedsDisplay()
    }
    
    
    
    /// setup items and add subviews
    func setupItems() {
        items = itemNames.flatMap { (text) -> UILabel in
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.font = font
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            return label
        }
    }
    
    /// setup items layout
    func setupAutoLayout() {
        if isHorizontal {
            layoutItems(bindAttrs: [.top, .bottom],
                            preAttr: .left,
                            nextAttr: .right,
                            equalAttr: .width)
        }
        else {
            layoutItems(bindAttrs: [.left, .right],
                            preAttr: .top,
                            nextAttr: .bottom,
                            equalAttr: .height)
        }
    }
    
    /// Detect selected index when click
    ///
    /// - Parameters:
    ///   - touch: touch
    ///   - event: event
    /// - Returns: false
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        selectedIndex = items.index { return $0.frame.contains(location) }!
        sendActions(for: .valueChanged)
        
        return false
    }
    
    /// layoutSubviews
    override open func layoutSubviews() {
        super.layoutSubviews()
        selectItemAtIndex()
    }
    
    /// Select and animate Item at index
    func selectItemAtIndex(){
    
        guard let label: UILabel = items.count > selectedIndex ? items[selectedIndex] : nil
            else { return }
        
        items.forEach({$0.textColor = unactiveColor})
        
        label.textColor = activeColor
        
        animateActiveItem(label)
        
    }
    
    
    /// UIView animate for active view item
    ///
    /// - Parameter label: selected item
    func animateActiveItem(_ label: UILabel) {
        let totalItems = CGFloat(itemNames.count)
        var labelFrame = self.bounds
        
        labelFrame.origin = label.frame.origin
        
        // AASegmentedControl direction
        if isHorizontal {
            labelFrame.size.width /= totalItems
        }
        else {
            labelFrame.size.height /= totalItems
        }
        
        // Active view under line or rectangle
        if activeUnderline {
            labelFrame.size.height = 4
            labelFrame.origin.y = label.frame.maxY - 2*(labelFrame.size.height)
        }
        
        // Allows daming effect
        if allowDamping {
            
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.6,
                           animations: {
                            
                            self.activeBackground.frame = labelFrame
                            
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.1,
                           delay: 0.0,
                           animations: {
                            
                            self.activeBackground.frame = labelFrame
                            
            }, completion: nil)
            
        }
    }
    
}


