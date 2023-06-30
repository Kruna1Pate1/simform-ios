//
//  PrimaryButton.swift
//  Demo
//
//  Created by Krunal Patel on 30/06/23.
//

import UIKit

@IBDesignable
class RangeSlider: UIControl {
    
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.2
    var upperValue: CGFloat = 0.8
    
    private var previousLocation = CGPoint()
    
    var thumbImage = UIImage(named: "circle")?.resizedImage(to: CGSize(width: 24, height: 24))
    
    override var frame: CGRect {
      didSet {
        updateLayerFrames()
      }
    }

    private let trackLayer = CALayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    // MARK: - Methods
    private func updateView() {
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
        updateLayerFrames()
    }
    
    private func updateLayerFrames() {
      trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
      trackLayer.setNeedsDisplay()
      lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                         size: thumbImage!.size)
      upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                         size: thumbImage!.size)
    }
    
    // 2
    func positionForValue(_ value: CGFloat) -> CGFloat {
      return bounds.width * value
    }
    
    // 3
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
      let x = positionForValue(value) - thumbImage!.size.width / 2.0
      return CGPoint(x: x, y: (bounds.height - thumbImage!.size.height) / 2.0)
    }
}

extension RangeSlider {
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    // 1
    previousLocation = touch.location(in: self)
    
    // 2
    if lowerThumbImageView.frame.contains(previousLocation) {
      lowerThumbImageView.isHighlighted = true
    } else if upperThumbImageView.frame.contains(previousLocation) {
      upperThumbImageView.isHighlighted = true
    }
    
    // 3
    return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
  }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
      let location = touch.location(in: self)
      
      // 1
      let deltaLocation = location.x - previousLocation.x
      let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
      
      previousLocation = location
      
      // 2
      if lowerThumbImageView.isHighlighted {
        lowerValue += deltaValue
        lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                upperValue: upperValue)
      } else if upperThumbImageView.isHighlighted {
        upperValue += deltaValue
        upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                upperValue: maximumValue)
      }
      
      // 3
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      
      updateLayerFrames()
      
      CATransaction.commit()
      
      return true
    }

    // 4
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
      return min(max(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
      lowerThumbImageView.isHighlighted = false
      upperThumbImageView.isHighlighted = false
    }
}

