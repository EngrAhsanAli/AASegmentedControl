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
    
    /// Disabled tabs
    open var disabledIndicies = Set<Int>() {
        didSet { setDisabledTabs() }
    }
    
    /// Tab color for disabled background segment
    open var disabledBackgroundColor: UIColor = .clear
    
    /// Tab color for disabled text color segment
    open var disabledTextColor: UIColor = .lightGray
    
    /// Selected Index
    open var selectedIndex : Int = 0 {
        didSet {
            selectItemAtIndex(true)
        }
    }
    
    /// @IBInspectable Allow daming animation
    @IBInspectable open var allowDamping: Bool = true
    
    /// AASegmentedControl underline titles only
    open var underLineTitles: Bool = false
    
    /// @IBInspectable Active underline height
    @IBInspectable open var underlineHeight: CGFloat = 0

    /// @IBInspectable text alignment
    @IBInspectable open var textAlignment: NSTextAlignment = .center
    
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
            layer.cornerRadius = borderRadius
        }
    }
    
    /// @IBInspectable border width
    @IBInspectable open var borderWidth: CGFloat = 2 {
        didSet {
            let maxWidth: CGFloat = 4
            if borderWidth > maxWidth {
                borderWidth = maxWidth
            }
            layer.borderWidth = borderWidth
        }
    }
    
    /// @IBInspectable Border color
    @IBInspectable open var borderColor : UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
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
    @IBInspectable open var activeBg: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Active background view
    lazy open var activeBackground: UIView = {
       let view = UIView()
        insertSubview(view, at: 0)
        return view
    }()
    
    /// Callback after completion of drawing elements
    open var onDrawCompletion: (() -> ())?
    
    /// Callback for disabled tab click
    open var onDisabledClick: ((Int) -> ())?
    
    /// draw
    ///
    /// - Parameter rect: rect
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = borderRadius
        layer.borderWidth = borderWidth
        
        activeBackground.backgroundColor = activeBg
        activeBackground.layer.cornerRadius = underlineHeight == 0 ? 0 : borderRadius
        
        setupItems()
        setupAutoLayout()
        onDrawCompletion?()
    }
    
    /// setup items and add subviews
    func setupItems() {
        guard segmentTitles.count != 0 else {
            fatalError("AASegmentedControl:- Titles shouldnt empty")
        }
        items = segmentTitles.compactMap { (text) -> UILabel in
            let label = UILabel()
            label.text = text
            label.textAlignment = textAlignment
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
    
    /// Set disabled tabs
    func setDisabledTabs() {
        disabledIndicies.forEach {
            if items.count > $0 {
                items[$0].backgroundColor = disabledBackgroundColor
                items[$0].textColor = disabledTextColor
            }
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
        if let index = items.firstIndex(where: { return $0.frame.contains(location) }), selectedIndex != index {
            if disabledIndicies.contains(index) { onDisabledClick?(index) }
            else {
                selectedIndex = index
                sendActions(for: .valueChanged)
            }
        }
        return false
    }
    
    /// layoutSubviews
    override open func layoutSubviews() {
        super.layoutSubviews()
        if underlineHeight != 0 {
            activeBackground.frame.size.height = underlineHeight
            activeBackground.frame.origin.y = frame.maxY - activeBackground.frame.size.height
        }
        selectItemAtIndex(false)
        setDisabledTabs()
    }
    
    /// Select and animate Item at index
    func selectItemAtIndex(_ animate: Bool) {
        
        guard let label: UILabel = items.count > selectedIndex ? items[selectedIndex] : nil, !disabledIndicies.contains(selectedIndex)
            else { return }
        items.forEach({$0.textColor = unactiveText})
        label.textColor = activeText
        animateActiveItem(label, animate: animate)
        
    }
    
    
    /// UIView animate for active view item
    ///
    /// - Parameter label: selected item
    func animateActiveItem(_ label: UILabel, animate: Bool) {
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
            self.activeBackground.frame.origin.y = labelFrame.origin.y
            
            if underLineTitles {
                labelFrame.size.width = label.intrinsicContentSize.width
                labelFrame.origin.x = label.center.x - (labelFrame.size.width/2)
            }
            
        }
        
        // Allows daming effect
        if allowDamping {
            
            UIView.animate(withDuration: animate ? 0.4 : 0,
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.6,
                           animations: {
                            
                            self.activeBackground.frame = labelFrame
                            
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: animate ? 0.1 : 0,
                           delay: 0.0,
                           animations: {
                            
                            self.activeBackground.frame = labelFrame
                            
            }, completion: nil)
            
        }
    }
    
}


