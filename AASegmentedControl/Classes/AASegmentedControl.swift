//
//  AASegmentedControl.swift
//  AASegmentedControl
//
//  Created by Engr. Ahsan Ali on 01/10/2017.
//  Copyright (c) 2017 AA-Creations. All rights reserved.
//

import UIKit

open class AASegmentedControl: UIControl {

    /// Item names
    open var segmentTitles: [String] = ["Tab 1", "Tab 2"]
    
    /// Font for items
    open var font: UIFont = UIFont.boldSystemFont(ofSize: 14)
    
    /// Items array for UILabel
    open var items: [UILabel] = [UILabel]()
    
    /// Selected Index
    open var selectedIndex : Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable Allow daming animation
    @IBInspectable open var allowDamping: Bool = false
    
    /// @IBInspectable Active underline height
    @IBInspectable open var underlineHeight: CGFloat = 0 {
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
    @IBInspectable open var borderRadius: CGFloat = 0 {
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
    @IBInspectable open var activeText : UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable unactive text color
    @IBInspectable open var unactiveText : UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// @IBInspectable active background color
    @IBInspectable open var activeBg: UIColor = .darkGray {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Active background view
    var activeBackground: UIView = UIView() {
        didSet {
            activeBackground.frame = itemFrame
            activeBackground.backgroundColor = activeBg
            activeBackground.layer.cornerRadius = underlineHeight == 0 ? 0 : borderRadius
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
        items = segmentTitles.compactMap { (text) -> UILabel in
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
        selectedIndex = items.firstIndex { return $0.frame.contains(location) }!
        sendActions(for: .valueChanged)
        
        return false
    }
    
    /// layoutSubviews
    override open func layoutSubviews() {
        super.layoutSubviews()
        selectItemAtIndex()
    }
    
    /// Select and animate Item at index
    func selectItemAtIndex() {
        
        guard let label: UILabel = items.count > selectedIndex ? items[selectedIndex] : nil
            else { return }
        items.forEach({$0.textColor = unactiveText})
        label.textColor = activeText
        animateActiveItem(label)
        
    }
    
    
    /// UIView animate for active view item
    ///
    /// - Parameter label: selected item
    func animateActiveItem(_ label: UILabel) {
        let totalItems = CGFloat(segmentTitles.count)
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
        if underlineHeight != 0 {
            labelFrame.size.height = underlineHeight
            labelFrame.origin.y = label.frame.maxY - (labelFrame.size.height)
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


