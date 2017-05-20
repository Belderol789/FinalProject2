//
//  UserInterfaceDesign.swift
//  FinalProject
//
//  Created by Yohan on 20/05/2017.
//  Copyright © 2017 Group2. All rights reserved.
//
//



import UIKit

public class UserInterfaceDesign : NSObject {

    //// Cache

    private struct Cache {
        static let foodCategory: UIColor = UIColor(red: 1.000, green: 0.685, blue: 0.000, alpha: 1.000)
        static let foodCategoryOverlay: UIColor = UserInterfaceDesign.foodCategory.withAlpha(0.3)
        static let entertainmentCategory: UIColor = UIColor(red: 0.710, green: 0.000, blue: 1.000, alpha: 1.000)
        static let entertainmentCategoryOverlay: UIColor = UserInterfaceDesign.entertainmentCategory.withAlpha(0.2)
        static let sportCategory: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static let sportCategoryOverlay: UIColor = UserInterfaceDesign.sportCategory.withAlpha(0.2)
        static let vacationCategory: UIColor = UIColor(red: 0.000, green: 0.999, blue: 1.000, alpha: 1.000)
        static let vacationCategoryOverlay: UIColor = UserInterfaceDesign.vacationCategory.withAlpha(0.2)
        static let discussionCategory: UIColor = UIColor(red: 0.000, green: 1.000, blue: 0.005, alpha: 1.000)
        static let discussionCategoryOverlay: UIColor = UserInterfaceDesign.discussionCategory.withAlpha(0.2)
        static let artCategory: UIColor = UIColor(red: 0.000, green: 0.117, blue: 1.000, alpha: 1.000)
        static let color: UIColor = UserInterfaceDesign.artCategory.withAlpha(0.3)
    }

    //// Colors

    public dynamic class var foodCategory: UIColor { return Cache.foodCategory }
    public dynamic class var foodCategoryOverlay: UIColor { return Cache.foodCategoryOverlay }
    public dynamic class var entertainmentCategory: UIColor { return Cache.entertainmentCategory }
    public dynamic class var entertainmentCategoryOverlay: UIColor { return Cache.entertainmentCategoryOverlay }
    public dynamic class var sportCategory: UIColor { return Cache.sportCategory }
    public dynamic class var sportCategoryOverlay: UIColor { return Cache.sportCategoryOverlay }
    public dynamic class var vacationCategory: UIColor { return Cache.vacationCategory }
    public dynamic class var vacationCategoryOverlay: UIColor { return Cache.vacationCategoryOverlay }
    public dynamic class var discussionCategory: UIColor { return Cache.discussionCategory }
    public dynamic class var discussionCategoryOverlay: UIColor { return Cache.discussionCategoryOverlay }
    public dynamic class var artCategory: UIColor { return Cache.artCategory }
    public dynamic class var color: UIColor { return Cache.color }

    //// Drawing Methods

    public dynamic class func drawEntertainmentCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 768, height: 768), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 768, height: 768), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 768, y: resizedFrame.height / 768)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let entertaintment = UIImage(named: "entertaintment.jpg")!
        let entertaintmentBlackAndWhite = UIImage(named: "entertaintmentBlackAndWhite.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -entertaintmentBlackAndWhite.size.height)
        context.draw(entertaintmentBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: entertaintmentBlackAndWhite.size.width, height: entertaintmentBlackAndWhite.size.height))
        context.restoreGState()


        //// Group 4
        //// Group 3
        //// Text Drawing
        let textRect = CGRect(x: 44, y: 108, width: 157, height: 203)
        let textTextContent = "E"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        //// Text 2 Drawing
        let text2Rect = CGRect(x: 564, y: 108, width: 157, height: 203)
        let text2TextContent = "R"
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .center
        let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text2Rect)
        text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        context.restoreGState()


        //// Text 4 Drawing
        let text4Rect = CGRect(x: 179, y: 108, width: 149, height: 203)
        let text4TextContent = "N"
        let text4Style = NSMutableParagraphStyle()
        text4Style.alignment = .center
        let text4FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text4Style]

        let text4TextHeight: CGFloat = text4TextContent.boundingRect(with: CGSize(width: text4Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text4FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text4Rect)
        text4TextContent.draw(in: CGRect(x: text4Rect.minX, y: text4Rect.minY + (text4Rect.height - text4TextHeight) / 2, width: text4Rect.width, height: text4TextHeight), withAttributes: text4FontAttributes)
        context.restoreGState()


        //// Text 5 Drawing
        let text5Rect = CGRect(x: 323, y: 108, width: 149, height: 203)
        let text5TextContent = "T"
        let text5Style = NSMutableParagraphStyle()
        text5Style.alignment = .center
        let text5FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text5Style]

        let text5TextHeight: CGFloat = text5TextContent.boundingRect(with: CGSize(width: text5Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text5FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text5Rect)
        text5TextContent.draw(in: CGRect(x: text5Rect.minX, y: text5Rect.minY + (text5Rect.height - text5TextHeight) / 2, width: text5Rect.width, height: text5TextHeight), withAttributes: text5FontAttributes)
        context.restoreGState()


        //// Text 6 Drawing
        let text6Rect = CGRect(x: 447, y: 108, width: 149, height: 203)
        let text6TextContent = "E"
        let text6Style = NSMutableParagraphStyle()
        text6Style.alignment = .center
        let text6FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text6Style]

        let text6TextHeight: CGFloat = text6TextContent.boundingRect(with: CGSize(width: text6Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text6FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text6Rect)
        text6TextContent.draw(in: CGRect(x: text6Rect.minX, y: text6Rect.minY + (text6Rect.height - text6TextHeight) / 2, width: text6Rect.width, height: text6TextHeight), withAttributes: text6FontAttributes)
        context.restoreGState()




        //// Group 2
        //// Text 7 Drawing
        let text7Rect = CGRect(x: 49, y: 283, width: 175, height: 203)
        let text7TextContent = "T"
        let text7Style = NSMutableParagraphStyle()
        text7Style.alignment = .center
        let text7FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text7Style]

        let text7TextHeight: CGFloat = text7TextContent.boundingRect(with: CGSize(width: text7Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text7FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text7Rect)
        text7TextContent.draw(in: CGRect(x: text7Rect.minX, y: text7Rect.minY + (text7Rect.height - text7TextHeight) / 2, width: text7Rect.width, height: text7TextHeight), withAttributes: text7FontAttributes)
        context.restoreGState()


        //// Text 8 Drawing
        let text8Rect = CGRect(x: 235, y: 283, width: 157, height: 203)
        let text8TextContent = "A"
        let text8Style = NSMutableParagraphStyle()
        text8Style.alignment = .center
        let text8FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text8Style]

        let text8TextHeight: CGFloat = text8TextContent.boundingRect(with: CGSize(width: text8Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text8FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text8Rect)
        text8TextContent.draw(in: CGRect(x: text8Rect.minX, y: text8Rect.minY + (text8Rect.height - text8TextHeight) / 2, width: text8Rect.width, height: text8TextHeight), withAttributes: text8FontAttributes)
        context.restoreGState()


        //// Text 9 Drawing
        let text9Rect = CGRect(x: 394, y: 283, width: 157, height: 203)
        let text9TextContent = "I"
        let text9Style = NSMutableParagraphStyle()
        text9Style.alignment = .center
        let text9FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text9Style]

        let text9TextHeight: CGFloat = text9TextContent.boundingRect(with: CGSize(width: text9Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text9FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text9Rect)
        text9TextContent.draw(in: CGRect(x: text9Rect.minX, y: text9Rect.minY + (text9Rect.height - text9TextHeight) / 2, width: text9Rect.width, height: text9TextHeight), withAttributes: text9FontAttributes)
        context.restoreGState()


        //// Text 10 Drawing
        let text10Rect = CGRect(x: 564, y: 283, width: 157, height: 203)
        let text10TextContent = "N"
        let text10Style = NSMutableParagraphStyle()
        text10Style.alignment = .center
        let text10FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text10Style]

        let text10TextHeight: CGFloat = text10TextContent.boundingRect(with: CGSize(width: text10Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text10FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text10Rect)
        text10TextContent.draw(in: CGRect(x: text10Rect.minX, y: text10Rect.minY + (text10Rect.height - text10TextHeight) / 2, width: text10Rect.width, height: text10TextHeight), withAttributes: text10FontAttributes)
        context.restoreGState()




        //// Group
        //// Text 3 Drawing
        let text3Rect = CGRect(x: 68, y: 457, width: 175, height: 203)
        let text3TextContent = "M"
        let text3Style = NSMutableParagraphStyle()
        text3Style.alignment = .center
        let text3FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text3Rect)
        text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
        context.restoreGState()


        //// Text 11 Drawing
        let text11Rect = CGRect(x: 250, y: 457, width: 157, height: 203)
        let text11TextContent = "E"
        let text11Style = NSMutableParagraphStyle()
        text11Style.alignment = .center
        let text11FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text11Style]

        let text11TextHeight: CGFloat = text11TextContent.boundingRect(with: CGSize(width: text11Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text11FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text11Rect)
        text11TextContent.draw(in: CGRect(x: text11Rect.minX, y: text11Rect.minY + (text11Rect.height - text11TextHeight) / 2, width: text11Rect.width, height: text11TextHeight), withAttributes: text11FontAttributes)
        context.restoreGState()


        //// Text 12 Drawing
        let text12Rect = CGRect(x: 408, y: 457, width: 157, height: 203)
        let text12TextContent = "N"
        let text12Style = NSMutableParagraphStyle()
        text12Style.alignment = .center
        let text12FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text12Style]

        let text12TextHeight: CGFloat = text12TextContent.boundingRect(with: CGSize(width: text12Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text12FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text12Rect)
        text12TextContent.draw(in: CGRect(x: text12Rect.minX, y: text12Rect.minY + (text12Rect.height - text12TextHeight) / 2, width: text12Rect.width, height: text12TextHeight), withAttributes: text12FontAttributes)
        context.restoreGState()


        //// Text 13 Drawing
        let text13Rect = CGRect(x: 567, y: 457, width: 157, height: 203)
        let text13TextContent = "T"
        let text13Style = NSMutableParagraphStyle()
        text13Style.alignment = .center
        let text13FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: UserInterfaceDesign.entertainmentCategory, NSParagraphStyleAttributeName: text13Style]

        let text13TextHeight: CGFloat = text13TextContent.boundingRect(with: CGSize(width: text13Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text13FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text13Rect)
        text13TextContent.draw(in: CGRect(x: text13Rect.minX, y: text13Rect.minY + (text13Rect.height - text13TextHeight) / 2, width: text13Rect.width, height: text13TextHeight), withAttributes: text13FontAttributes)
        context.restoreGState()






        if (pressed) {
            //// Group 5
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -entertaintment.size.height)
            context.draw(entertaintment.cgImage!, in: CGRect(x: 0, y: 0, width: entertaintment.size.width, height: entertaintment.size.height))
            context.restoreGState()


            //// Group 6
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
            UserInterfaceDesign.entertainmentCategoryOverlay.setFill()
            rectanglePath.fill()


            //// Group 7
            //// Text 14 Drawing
            let text14Rect = CGRect(x: 44, y: 108, width: 157, height: 203)
            let text14TextContent = "E"
            let text14Style = NSMutableParagraphStyle()
            text14Style.alignment = .center
            let text14FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text14Style]

            let text14TextHeight: CGFloat = text14TextContent.boundingRect(with: CGSize(width: text14Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text14FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text14Rect)
            text14TextContent.draw(in: CGRect(x: text14Rect.minX, y: text14Rect.minY + (text14Rect.height - text14TextHeight) / 2, width: text14Rect.width, height: text14TextHeight), withAttributes: text14FontAttributes)
            context.restoreGState()


            //// Text 15 Drawing
            let text15Rect = CGRect(x: 564, y: 108, width: 157, height: 203)
            let text15TextContent = "R"
            let text15Style = NSMutableParagraphStyle()
            text15Style.alignment = .center
            let text15FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text15Style]

            let text15TextHeight: CGFloat = text15TextContent.boundingRect(with: CGSize(width: text15Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text15FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text15Rect)
            text15TextContent.draw(in: CGRect(x: text15Rect.minX, y: text15Rect.minY + (text15Rect.height - text15TextHeight) / 2, width: text15Rect.width, height: text15TextHeight), withAttributes: text15FontAttributes)
            context.restoreGState()


            //// Text 16 Drawing
            let text16Rect = CGRect(x: 179, y: 108, width: 149, height: 203)
            let text16TextContent = "N"
            let text16Style = NSMutableParagraphStyle()
            text16Style.alignment = .center
            let text16FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text16Style]

            let text16TextHeight: CGFloat = text16TextContent.boundingRect(with: CGSize(width: text16Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text16FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text16Rect)
            text16TextContent.draw(in: CGRect(x: text16Rect.minX, y: text16Rect.minY + (text16Rect.height - text16TextHeight) / 2, width: text16Rect.width, height: text16TextHeight), withAttributes: text16FontAttributes)
            context.restoreGState()


            //// Text 17 Drawing
            let text17Rect = CGRect(x: 323, y: 108, width: 149, height: 203)
            let text17TextContent = "T"
            let text17Style = NSMutableParagraphStyle()
            text17Style.alignment = .center
            let text17FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text17Style]

            let text17TextHeight: CGFloat = text17TextContent.boundingRect(with: CGSize(width: text17Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text17FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text17Rect)
            text17TextContent.draw(in: CGRect(x: text17Rect.minX, y: text17Rect.minY + (text17Rect.height - text17TextHeight) / 2, width: text17Rect.width, height: text17TextHeight), withAttributes: text17FontAttributes)
            context.restoreGState()


            //// Text 18 Drawing
            let text18Rect = CGRect(x: 447, y: 108, width: 149, height: 203)
            let text18TextContent = "E"
            let text18Style = NSMutableParagraphStyle()
            text18Style.alignment = .center
            let text18FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text18Style]

            let text18TextHeight: CGFloat = text18TextContent.boundingRect(with: CGSize(width: text18Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text18FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text18Rect)
            text18TextContent.draw(in: CGRect(x: text18Rect.minX, y: text18Rect.minY + (text18Rect.height - text18TextHeight) / 2, width: text18Rect.width, height: text18TextHeight), withAttributes: text18FontAttributes)
            context.restoreGState()




            //// Group 8
            //// Text 19 Drawing
            let text19Rect = CGRect(x: 49, y: 283, width: 175, height: 203)
            let text19TextContent = "T"
            let text19Style = NSMutableParagraphStyle()
            text19Style.alignment = .center
            let text19FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text19Style]

            let text19TextHeight: CGFloat = text19TextContent.boundingRect(with: CGSize(width: text19Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text19FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text19Rect)
            text19TextContent.draw(in: CGRect(x: text19Rect.minX, y: text19Rect.minY + (text19Rect.height - text19TextHeight) / 2, width: text19Rect.width, height: text19TextHeight), withAttributes: text19FontAttributes)
            context.restoreGState()


            //// Text 20 Drawing
            let text20Rect = CGRect(x: 235, y: 283, width: 157, height: 203)
            let text20TextContent = "A"
            let text20Style = NSMutableParagraphStyle()
            text20Style.alignment = .center
            let text20FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text20Style]

            let text20TextHeight: CGFloat = text20TextContent.boundingRect(with: CGSize(width: text20Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text20FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text20Rect)
            text20TextContent.draw(in: CGRect(x: text20Rect.minX, y: text20Rect.minY + (text20Rect.height - text20TextHeight) / 2, width: text20Rect.width, height: text20TextHeight), withAttributes: text20FontAttributes)
            context.restoreGState()


            //// Text 21 Drawing
            let text21Rect = CGRect(x: 394, y: 283, width: 157, height: 203)
            let text21TextContent = "I"
            let text21Style = NSMutableParagraphStyle()
            text21Style.alignment = .center
            let text21FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text21Style]

            let text21TextHeight: CGFloat = text21TextContent.boundingRect(with: CGSize(width: text21Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text21FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text21Rect)
            text21TextContent.draw(in: CGRect(x: text21Rect.minX, y: text21Rect.minY + (text21Rect.height - text21TextHeight) / 2, width: text21Rect.width, height: text21TextHeight), withAttributes: text21FontAttributes)
            context.restoreGState()


            //// Text 22 Drawing
            let text22Rect = CGRect(x: 564, y: 283, width: 157, height: 203)
            let text22TextContent = "N"
            let text22Style = NSMutableParagraphStyle()
            text22Style.alignment = .center
            let text22FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text22Style]

            let text22TextHeight: CGFloat = text22TextContent.boundingRect(with: CGSize(width: text22Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text22FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text22Rect)
            text22TextContent.draw(in: CGRect(x: text22Rect.minX, y: text22Rect.minY + (text22Rect.height - text22TextHeight) / 2, width: text22Rect.width, height: text22TextHeight), withAttributes: text22FontAttributes)
            context.restoreGState()




            //// Group 9
            //// Text 23 Drawing
            let text23Rect = CGRect(x: 68, y: 457, width: 175, height: 203)
            let text23TextContent = "M"
            let text23Style = NSMutableParagraphStyle()
            text23Style.alignment = .center
            let text23FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text23Style]

            let text23TextHeight: CGFloat = text23TextContent.boundingRect(with: CGSize(width: text23Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text23FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text23Rect)
            text23TextContent.draw(in: CGRect(x: text23Rect.minX, y: text23Rect.minY + (text23Rect.height - text23TextHeight) / 2, width: text23Rect.width, height: text23TextHeight), withAttributes: text23FontAttributes)
            context.restoreGState()


            //// Text 24 Drawing
            let text24Rect = CGRect(x: 250, y: 457, width: 157, height: 203)
            let text24TextContent = "E"
            let text24Style = NSMutableParagraphStyle()
            text24Style.alignment = .center
            let text24FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text24Style]

            let text24TextHeight: CGFloat = text24TextContent.boundingRect(with: CGSize(width: text24Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text24FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text24Rect)
            text24TextContent.draw(in: CGRect(x: text24Rect.minX, y: text24Rect.minY + (text24Rect.height - text24TextHeight) / 2, width: text24Rect.width, height: text24TextHeight), withAttributes: text24FontAttributes)
            context.restoreGState()


            //// Text 25 Drawing
            let text25Rect = CGRect(x: 408, y: 457, width: 157, height: 203)
            let text25TextContent = "N"
            let text25Style = NSMutableParagraphStyle()
            text25Style.alignment = .center
            let text25FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text25Style]

            let text25TextHeight: CGFloat = text25TextContent.boundingRect(with: CGSize(width: text25Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text25FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text25Rect)
            text25TextContent.draw(in: CGRect(x: text25Rect.minX, y: text25Rect.minY + (text25Rect.height - text25TextHeight) / 2, width: text25Rect.width, height: text25TextHeight), withAttributes: text25FontAttributes)
            context.restoreGState()


            //// Text 26 Drawing
            let text26Rect = CGRect(x: 567, y: 457, width: 157, height: 203)
            let text26TextContent = "T"
            let text26Style = NSMutableParagraphStyle()
            text26Style.alignment = .center
            let text26FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 223), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text26Style]

            let text26TextHeight: CGFloat = text26TextContent.boundingRect(with: CGSize(width: text26Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text26FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text26Rect)
            text26TextContent.draw(in: CGRect(x: text26Rect.minX, y: text26Rect.minY + (text26Rect.height - text26TextHeight) / 2, width: text26Rect.width, height: text26TextHeight), withAttributes: text26FontAttributes)
            context.restoreGState()






        }
        
        context.restoreGState()

    }

    public dynamic class func drawFoodCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 800, height: 800), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 800, height: 800), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 800, y: resizedFrame.height / 800)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let food = UIImage(named: "food.jpg")!
        let foodBlackAndWhite = UIImage(named: "foodBlackAndWhite.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 800, height: 800))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -foodBlackAndWhite.size.height)
        context.draw(foodBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: foodBlackAndWhite.size.width, height: foodBlackAndWhite.size.height))
        context.restoreGState()


        //// Text Drawing
        let textRect = CGRect(x: 66, y: 239, width: 669, height: 322)
        let textTextContent = "FOOD"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 250), NSForegroundColorAttributeName: UserInterfaceDesign.foodCategory, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        if (pressed) {
            //// Group
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 800, height: 800))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -food.size.height)
            context.draw(food.cgImage!, in: CGRect(x: 0, y: 0, width: food.size.width, height: food.size.height))
            context.restoreGState()


            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 1, y: 0, width: 800, height: 800))
            UserInterfaceDesign.foodCategoryOverlay.setFill()
            rectanglePath.fill()


            //// Text 2 Drawing
            let text2Rect = CGRect(x: 66, y: 239, width: 669, height: 322)
            let text2TextContent = "FOOD"
            let text2Style = NSMutableParagraphStyle()
            text2Style.alignment = .left
            let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 250), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text2Style]

            let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text2Rect)
            text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
            context.restoreGState()


        }
        
        context.restoreGState()

    }

    public dynamic class func drawSportCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 563, height: 563), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 563, height: 563), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 563, y: resizedFrame.height / 563)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let sport = UIImage(named: "sport.jpg")!
        let sportBlackAndWhite = UIImage(named: "sportBlackAndWhite.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 563, height: 563))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -sportBlackAndWhite.size.height)
        context.draw(sportBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: sportBlackAndWhite.size.width, height: sportBlackAndWhite.size.height))
        context.restoreGState()


        //// Text Drawing
        let textRect = CGRect(x: 31, y: 180, width: 502, height: 202)
        let textTextContent = "SPORT"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 160), NSForegroundColorAttributeName: UserInterfaceDesign.sportCategory, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        if (pressed) {
            //// Group
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 563, height: 563))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -sport.size.height)
            context.draw(sport.cgImage!, in: CGRect(x: 0, y: 0, width: sport.size.width, height: sport.size.height))
            context.restoreGState()


            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 563, height: 563))
            UserInterfaceDesign.sportCategoryOverlay.setFill()
            rectanglePath.fill()


            //// Text 2 Drawing
            let text2Rect = CGRect(x: 31, y: 180, width: 502, height: 202)
            let text2TextContent = "SPORT"
            let text2Style = NSMutableParagraphStyle()
            text2Style.alignment = .left
            let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 160), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text2Style]

            let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text2Rect)
            text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
            context.restoreGState()


        }
        
        context.restoreGState()

    }

    public dynamic class func drawDiscussionCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 533, height: 533), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 533, height: 533), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 533, y: resizedFrame.height / 533)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let discussionBlackAndWhite = UIImage(named: "discussionBlackAndWhite.jpg")!
        let discussion = UIImage(named: "discussion.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 533, height: 533))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -discussionBlackAndWhite.size.height)
        context.draw(discussionBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: discussionBlackAndWhite.size.width, height: discussionBlackAndWhite.size.height))
        context.restoreGState()


        //// Group
        //// Text 3 Drawing
        let text3Rect = CGRect(x: 21, y: 111, width: 109, height: 202)
        let text3TextContent = "D"
        let text3Style = NSMutableParagraphStyle()
        text3Style.alignment = .center
        let text3FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text3Rect)
        text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
        context.restoreGState()


        //// Text Drawing
        let textRect = CGRect(x: 85, y: 111, width: 109, height: 202)
        let textTextContent = "I"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        //// Text 2 Drawing
        let text2Rect = CGRect(x: 143, y: 111, width: 109, height: 202)
        let text2TextContent = "S"
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .center
        let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text2Rect)
        text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        context.restoreGState()


        //// Text 4 Drawing
        let text4Rect = CGRect(x: 230, y: 111, width: 109, height: 202)
        let text4TextContent = "C"
        let text4Style = NSMutableParagraphStyle()
        text4Style.alignment = .center
        let text4FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text4Style]

        let text4TextHeight: CGFloat = text4TextContent.boundingRect(with: CGSize(width: text4Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text4FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text4Rect)
        text4TextContent.draw(in: CGRect(x: text4Rect.minX, y: text4Rect.minY + (text4Rect.height - text4TextHeight) / 2, width: text4Rect.width, height: text4TextHeight), withAttributes: text4FontAttributes)
        context.restoreGState()


        //// Text 5 Drawing
        let text5Rect = CGRect(x: 322, y: 111, width: 109, height: 202)
        let text5TextContent = "U"
        let text5Style = NSMutableParagraphStyle()
        text5Style.alignment = .center
        let text5FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text5Style]

        let text5TextHeight: CGFloat = text5TextContent.boundingRect(with: CGSize(width: text5Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text5FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text5Rect)
        text5TextContent.draw(in: CGRect(x: text5Rect.minX, y: text5Rect.minY + (text5Rect.height - text5TextHeight) / 2, width: text5Rect.width, height: text5TextHeight), withAttributes: text5FontAttributes)
        context.restoreGState()


        //// Text 6 Drawing
        let text6Rect = CGRect(x: 404, y: 111, width: 109, height: 202)
        let text6TextContent = "S"
        let text6Style = NSMutableParagraphStyle()
        text6Style.alignment = .center
        let text6FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text6Style]

        let text6TextHeight: CGFloat = text6TextContent.boundingRect(with: CGSize(width: text6Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text6FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text6Rect)
        text6TextContent.draw(in: CGRect(x: text6Rect.minX, y: text6Rect.minY + (text6Rect.height - text6TextHeight) / 2, width: text6Rect.width, height: text6TextHeight), withAttributes: text6FontAttributes)
        context.restoreGState()


        //// Text 7 Drawing
        let text7Rect = CGRect(x: 21, y: 220, width: 109, height: 202)
        let text7TextContent = "S"
        let text7Style = NSMutableParagraphStyle()
        text7Style.alignment = .center
        let text7FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text7Style]

        let text7TextHeight: CGFloat = text7TextContent.boundingRect(with: CGSize(width: text7Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text7FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text7Rect)
        text7TextContent.draw(in: CGRect(x: text7Rect.minX, y: text7Rect.minY + (text7Rect.height - text7TextHeight) / 2, width: text7Rect.width, height: text7TextHeight), withAttributes: text7FontAttributes)
        context.restoreGState()


        //// Text 8 Drawing
        let text8Rect = CGRect(x: 139, y: 220, width: 109, height: 202)
        let text8TextContent = "I"
        let text8Style = NSMutableParagraphStyle()
        text8Style.alignment = .center
        let text8FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text8Style]

        let text8TextHeight: CGFloat = text8TextContent.boundingRect(with: CGSize(width: text8Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text8FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text8Rect)
        text8TextContent.draw(in: CGRect(x: text8Rect.minX, y: text8Rect.minY + (text8Rect.height - text8TextHeight) / 2, width: text8Rect.width, height: text8TextHeight), withAttributes: text8FontAttributes)
        context.restoreGState()


        //// Text 9 Drawing
        let text9Rect = CGRect(x: 261, y: 220, width: 109, height: 202)
        let text9TextContent = "O"
        let text9Style = NSMutableParagraphStyle()
        text9Style.alignment = .center
        let text9FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text9Style]

        let text9TextHeight: CGFloat = text9TextContent.boundingRect(with: CGSize(width: text9Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text9FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text9Rect)
        text9TextContent.draw(in: CGRect(x: text9Rect.minX, y: text9Rect.minY + (text9Rect.height - text9TextHeight) / 2, width: text9Rect.width, height: text9TextHeight), withAttributes: text9FontAttributes)
        context.restoreGState()


        //// Text 10 Drawing
        let text10Rect = CGRect(x: 404, y: 220, width: 109, height: 202)
        let text10TextContent = "N"
        let text10Style = NSMutableParagraphStyle()
        text10Style.alignment = .center
        let text10FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: UserInterfaceDesign.discussionCategory, NSParagraphStyleAttributeName: text10Style]

        let text10TextHeight: CGFloat = text10TextContent.boundingRect(with: CGSize(width: text10Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text10FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text10Rect)
        text10TextContent.draw(in: CGRect(x: text10Rect.minX, y: text10Rect.minY + (text10Rect.height - text10TextHeight) / 2, width: text10Rect.width, height: text10TextHeight), withAttributes: text10FontAttributes)
        context.restoreGState()




        if (pressed) {
            //// Group 2
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 533, height: 533))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -discussion.size.height)
            context.draw(discussion.cgImage!, in: CGRect(x: 0, y: 0, width: discussion.size.width, height: discussion.size.height))
            context.restoreGState()


            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 533, height: 533))
            UserInterfaceDesign.discussionCategoryOverlay.setFill()
            rectanglePath.fill()


            //// Group 3
            //// Text 11 Drawing
            let text11Rect = CGRect(x: 21, y: 111, width: 109, height: 202)
            let text11TextContent = "D"
            let text11Style = NSMutableParagraphStyle()
            text11Style.alignment = .center
            let text11FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text11Style]

            let text11TextHeight: CGFloat = text11TextContent.boundingRect(with: CGSize(width: text11Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text11FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text11Rect)
            text11TextContent.draw(in: CGRect(x: text11Rect.minX, y: text11Rect.minY + (text11Rect.height - text11TextHeight) / 2, width: text11Rect.width, height: text11TextHeight), withAttributes: text11FontAttributes)
            context.restoreGState()


            //// Text 12 Drawing
            let text12Rect = CGRect(x: 85, y: 111, width: 109, height: 202)
            let text12TextContent = "I"
            let text12Style = NSMutableParagraphStyle()
            text12Style.alignment = .center
            let text12FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text12Style]

            let text12TextHeight: CGFloat = text12TextContent.boundingRect(with: CGSize(width: text12Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text12FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text12Rect)
            text12TextContent.draw(in: CGRect(x: text12Rect.minX, y: text12Rect.minY + (text12Rect.height - text12TextHeight) / 2, width: text12Rect.width, height: text12TextHeight), withAttributes: text12FontAttributes)
            context.restoreGState()


            //// Text 13 Drawing
            let text13Rect = CGRect(x: 143, y: 111, width: 109, height: 202)
            let text13TextContent = "S"
            let text13Style = NSMutableParagraphStyle()
            text13Style.alignment = .center
            let text13FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text13Style]

            let text13TextHeight: CGFloat = text13TextContent.boundingRect(with: CGSize(width: text13Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text13FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text13Rect)
            text13TextContent.draw(in: CGRect(x: text13Rect.minX, y: text13Rect.minY + (text13Rect.height - text13TextHeight) / 2, width: text13Rect.width, height: text13TextHeight), withAttributes: text13FontAttributes)
            context.restoreGState()


            //// Text 14 Drawing
            let text14Rect = CGRect(x: 230, y: 111, width: 109, height: 202)
            let text14TextContent = "C"
            let text14Style = NSMutableParagraphStyle()
            text14Style.alignment = .center
            let text14FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text14Style]

            let text14TextHeight: CGFloat = text14TextContent.boundingRect(with: CGSize(width: text14Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text14FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text14Rect)
            text14TextContent.draw(in: CGRect(x: text14Rect.minX, y: text14Rect.minY + (text14Rect.height - text14TextHeight) / 2, width: text14Rect.width, height: text14TextHeight), withAttributes: text14FontAttributes)
            context.restoreGState()


            //// Text 15 Drawing
            let text15Rect = CGRect(x: 322, y: 111, width: 109, height: 202)
            let text15TextContent = "U"
            let text15Style = NSMutableParagraphStyle()
            text15Style.alignment = .center
            let text15FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text15Style]

            let text15TextHeight: CGFloat = text15TextContent.boundingRect(with: CGSize(width: text15Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text15FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text15Rect)
            text15TextContent.draw(in: CGRect(x: text15Rect.minX, y: text15Rect.minY + (text15Rect.height - text15TextHeight) / 2, width: text15Rect.width, height: text15TextHeight), withAttributes: text15FontAttributes)
            context.restoreGState()


            //// Text 16 Drawing
            let text16Rect = CGRect(x: 404, y: 111, width: 109, height: 202)
            let text16TextContent = "S"
            let text16Style = NSMutableParagraphStyle()
            text16Style.alignment = .center
            let text16FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text16Style]

            let text16TextHeight: CGFloat = text16TextContent.boundingRect(with: CGSize(width: text16Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text16FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text16Rect)
            text16TextContent.draw(in: CGRect(x: text16Rect.minX, y: text16Rect.minY + (text16Rect.height - text16TextHeight) / 2, width: text16Rect.width, height: text16TextHeight), withAttributes: text16FontAttributes)
            context.restoreGState()


            //// Text 17 Drawing
            let text17Rect = CGRect(x: 21, y: 220, width: 109, height: 202)
            let text17TextContent = "S"
            let text17Style = NSMutableParagraphStyle()
            text17Style.alignment = .center
            let text17FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text17Style]

            let text17TextHeight: CGFloat = text17TextContent.boundingRect(with: CGSize(width: text17Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text17FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text17Rect)
            text17TextContent.draw(in: CGRect(x: text17Rect.minX, y: text17Rect.minY + (text17Rect.height - text17TextHeight) / 2, width: text17Rect.width, height: text17TextHeight), withAttributes: text17FontAttributes)
            context.restoreGState()


            //// Text 18 Drawing
            let text18Rect = CGRect(x: 136, y: 220, width: 109, height: 202)
            let text18TextContent = "I"
            let text18Style = NSMutableParagraphStyle()
            text18Style.alignment = .center
            let text18FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text18Style]

            let text18TextHeight: CGFloat = text18TextContent.boundingRect(with: CGSize(width: text18Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text18FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text18Rect)
            text18TextContent.draw(in: CGRect(x: text18Rect.minX, y: text18Rect.minY + (text18Rect.height - text18TextHeight) / 2, width: text18Rect.width, height: text18TextHeight), withAttributes: text18FontAttributes)
            context.restoreGState()


            //// Text 19 Drawing
            let text19Rect = CGRect(x: 258, y: 220, width: 109, height: 202)
            let text19TextContent = "O"
            let text19Style = NSMutableParagraphStyle()
            text19Style.alignment = .center
            let text19FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text19Style]

            let text19TextHeight: CGFloat = text19TextContent.boundingRect(with: CGSize(width: text19Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text19FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text19Rect)
            text19TextContent.draw(in: CGRect(x: text19Rect.minX, y: text19Rect.minY + (text19Rect.height - text19TextHeight) / 2, width: text19Rect.width, height: text19TextHeight), withAttributes: text19FontAttributes)
            context.restoreGState()


            //// Text 20 Drawing
            let text20Rect = CGRect(x: 401, y: 220, width: 109, height: 202)
            let text20TextContent = "N"
            let text20Style = NSMutableParagraphStyle()
            text20Style.alignment = .center
            let text20FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 130), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: text20Style]

            let text20TextHeight: CGFloat = text20TextContent.boundingRect(with: CGSize(width: text20Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text20FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text20Rect)
            text20TextContent.draw(in: CGRect(x: text20Rect.minX, y: text20Rect.minY + (text20Rect.height - text20TextHeight) / 2, width: text20Rect.width, height: text20TextHeight), withAttributes: text20FontAttributes)
            context.restoreGState()




        }
        
        context.restoreGState()

    }

    public dynamic class func drawVacationCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 564, height: 564), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 564, height: 564), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 564, y: resizedFrame.height / 564)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let vacation = UIImage(named: "vacation.jpg")!
        let vacationBlackAndWhite = UIImage(named: "vacationBlackAndWhite.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 564, height: 564))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -vacationBlackAndWhite.size.height)
        context.draw(vacationBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: vacationBlackAndWhite.size.width, height: vacationBlackAndWhite.size.height))
        context.restoreGState()


        //// Text 3 Drawing
        let text3Rect = CGRect(x: 31, y: 181, width: 502, height: 202)
        let text3TextContent = "VACATION"
        let text3Style = NSMutableParagraphStyle()
        text3Style.alignment = .left
        let text3FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 108), NSForegroundColorAttributeName: UserInterfaceDesign.vacationCategory, NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text3Rect)
        text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
        context.restoreGState()


        if (pressed) {
            //// Group
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 564, height: 564))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -vacation.size.height)
            context.draw(vacation.cgImage!, in: CGRect(x: 0, y: 0, width: vacation.size.width, height: vacation.size.height))
            context.restoreGState()


            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 564, height: 564))
            UserInterfaceDesign.vacationCategoryOverlay.setFill()
            rectanglePath.fill()


            //// Text Drawing
            let textRect = CGRect(x: 31, y: 181, width: 502, height: 202)
            let textTextContent = "VACATION"
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .left
            let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 108), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: textStyle]

            let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: textRect)
            textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
            context.restoreGState()


        }
        
        context.restoreGState()

    }

    public dynamic class func drawArtCategory(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 768, height: 768), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 768, height: 768), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 768, y: resizedFrame.height / 768)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Image Declarations
        let artBlackAndWhite = UIImage(named: "artBlackAndWhite.jpg")!
        let art = UIImage(named: "art.jpg")!

        //// Picture Drawing
        let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
        context.saveGState()
        picturePath.addClip()
        context.translateBy(x: 0, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -artBlackAndWhite.size.height)
        context.draw(artBlackAndWhite.cgImage!, in: CGRect(x: 0, y: 0, width: artBlackAndWhite.size.width, height: artBlackAndWhite.size.height))
        context.restoreGState()


        //// Text 2 Drawing
        let text2Rect = CGRect(x: 50, y: 223, width: 669, height: 322)
        let text2TextContent = "ART"
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .center
        let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 250), NSForegroundColorAttributeName: UserInterfaceDesign.artCategory, NSParagraphStyleAttributeName: text2Style]

        let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text2Rect)
        text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        context.restoreGState()


        if (pressed) {
            //// Group
            //// Picture 2 Drawing
            let picture2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
            context.saveGState()
            picture2Path.addClip()
            context.translateBy(x: 0, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -art.size.height)
            context.draw(art.cgImage!, in: CGRect(x: 0, y: 0, width: art.size.width, height: art.size.height))
            context.restoreGState()


            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 768, height: 768))
            UserInterfaceDesign.color.setFill()
            rectanglePath.fill()


            //// Text Drawing
            let textRect = CGRect(x: 50, y: 223, width: 669, height: 322)
            let textTextContent = "ART"
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 250), NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: textStyle]

            let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: textRect)
            textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
            context.restoreGState()


        }
        
        context.restoreGState()

    }

    public dynamic class func drawCustomTextField(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 370, height: 55), resizing: ResizingBehavior = .aspectFit, pressed: Bool = true, textFieldText: String = "Default") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 370, height: 55), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 370, y: resizedFrame.height / 55)


        //// Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let grey = UIColor(red: 0.734, green: 0.731, blue: 0.731, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 9.5, y: 49.5))
        bezierPath.addLine(to: CGPoint(x: 359.5, y: 49.5))
        grey.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()


        //// Text Drawing
        let textRect = CGRect(x: 10, y: 28, width: 105, height: 15)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: grey, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textFieldText.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textFieldText.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        if (pressed) {
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRect(x: 10, y: 28, width: 347, height: 24))
            white.setFill()
            rectanglePath.fill()


            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: 9.5, y: 49.5))
            bezier2Path.addLine(to: CGPoint(x: 359.5, y: 49.5))
            grey.setStroke()
            bezier2Path.lineWidth = 3
            bezier2Path.stroke()


            //// Text 2 Drawing
            let text2Rect = CGRect(x: 10, y: 13, width: 105, height: 15)
            let text2Style = NSMutableParagraphStyle()
            text2Style.alignment = .left
            let text2FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize), NSForegroundColorAttributeName: grey, NSParagraphStyleAttributeName: text2Style]

            let text2TextHeight: CGFloat = textFieldText.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
            context.saveGState()
            context.clip(to: text2Rect)
            textFieldText.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
            context.restoreGState()


        }
        
        context.restoreGState()

    }

    //// Generated Images

    public dynamic class func imageOfEntertainmentCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 768, height: 768), false, 0)
            UserInterfaceDesign.drawEntertainmentCategory(pressed: pressed)

        let imageOfEntertainmentCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfEntertainmentCategory
    }

    public dynamic class func imageOfFoodCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 800, height: 800), false, 0)
            UserInterfaceDesign.drawFoodCategory(pressed: pressed)

        let imageOfFoodCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfFoodCategory
    }

    public dynamic class func imageOfSportCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 563, height: 563), false, 0)
            UserInterfaceDesign.drawSportCategory(pressed: pressed)

        let imageOfSportCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfSportCategory
    }

    public dynamic class func imageOfDiscussionCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 533, height: 533), false, 0)
            UserInterfaceDesign.drawDiscussionCategory(pressed: pressed)

        let imageOfDiscussionCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfDiscussionCategory
    }

    public dynamic class func imageOfVacationCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 564, height: 564), false, 0)
            UserInterfaceDesign.drawVacationCategory(pressed: pressed)

        let imageOfVacationCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfVacationCategory
    }

    public dynamic class func imageOfArtCategory(pressed: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 768, height: 768), false, 0)
            UserInterfaceDesign.drawArtCategory(pressed: pressed)

        let imageOfArtCategory = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfArtCategory
    }

    public dynamic class func imageOfCustomTextField(pressed: Bool = true, textFieldText: String = "Default") -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 370, height: 55), false, 0)
            UserInterfaceDesign.drawCustomTextField(pressed: pressed, textFieldText: textFieldText)

        let imageOfCustomTextField = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfCustomTextField
    }




    @objc(UserInterfaceDesignResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}



private extension UIColor {
    func withHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func withSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func withBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func withAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, brightness: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func highlight(withLevel highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func shadow(withLevel shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}
