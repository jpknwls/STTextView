//  Created by Marcin Krzyzanowski
//  https://github.com/krzyzanowskim/STTextView/blob/main/LICENSE.md

import Foundation
import Cocoa

public protocol STInsertionPoint: STCALayer {
    init(frame frameRect: CGRect)

    var insertionPointColor: NSColor { get set }
    func enable()
    func disable()
    func updateGeometry()
}

open class STInsertionPointLayer: STCALayer, STInsertionPoint {
    private var timer: Timer?
    open var insertionPointWidth: CGFloat = 1 {
        didSet {
            frame.size.width = insertionPointWidth
        }
    }

    open var insertionPointColor: NSColor = .textColor {
        didSet {
            backgroundColor = insertionPointColor.cgColor
        }
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public override required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        frame = frameRect
        commonInit()
    }

    private func commonInit() {
        updateGeometry()
    }

    public func updateGeometry() {
        frame = frame.insetBy(dx: 0, dy: 1)
        frame.size.width = insertionPointWidth
        backgroundColor = insertionPointColor.cgColor
    }

    open func enable() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.isHidden.toggle()
        }
    }

    open func disable() {
        timer = nil
    }
}
