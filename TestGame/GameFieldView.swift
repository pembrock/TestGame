//
//  GameFieldView.swift
//  TestGame
//
//  Created by Pasikuta Kirill on 12.07.2019.
//  Copyright © 2019 Pasikuta Kirill. All rights reserved.
//

import UIKit

class GameFieldView: UIView {
    var shapeColor: UIColor = .red
    var shapePosition: CGPoint = .zero
    var shapeSize: CGSize = CGSize(width: 40, height: 40)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        shapeColor.setFill()
        let path = getTrianglePath(in: CGRect(origin: shapePosition, size: shapeSize))
        path.fill()
    }
    
    private func getTrianglePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 0
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.close()
        path.stroke()
        path.fill()
        
        return path
    }
}
