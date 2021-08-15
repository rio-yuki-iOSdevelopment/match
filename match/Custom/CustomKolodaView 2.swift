//
//  CustomKolodaView.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/06.
//
import UIKit
import Koloda

let defaultTopOffset: CGFloat = 100
let defaultHorizontalOffset: CGFloat = 10
let defaultHeightRatio: CGFloat = 1.25
let backgroundCardHorizontalMarginMultiplier: CGFloat = 0.25
let backgroundCardScalePercent: CGFloat = 1.5

class CustomKolodaView: KolodaView {

    override func frameForCard(at index: Int) -> CGRect {
//        一番上のカード
        if index == 0 {
//            上の余白
            let topOffset: CGFloat = defaultTopOffset
//            左の余白
            let xOffset: CGFloat = defaultHorizontalOffset
//            カードの横幅　比率
            let width = (self.frame).width - 2 * defaultHorizontalOffset
//            カードの縦幅
            let height = width * defaultHeightRatio
//            上の余白
            let yOffset: CGFloat = topOffset
//            以上の設定で固定
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            
            return frame
//            次のカード
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardHorizontalMarginMultiplier
            let width = self.bounds.width * backgroundCardScalePercent
            let height = width * defaultHeightRatio
            return CGRect(x: horizontalMargin, y: 0, width: width, height: height)
        }
        return CGRect.zero
    }

}
