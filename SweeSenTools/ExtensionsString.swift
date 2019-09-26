//
//  ExtensionsString.swift
//  SweeSenTools
//
//  Created by Koh Sweesen on 27/7/19.
//  Copyright © 2019 Koh Swee Sen. All rights reserved.
//

import Foundation



//adding styles to String to become Attributed String
public extension String {
    
    func with(fontSize:CGFloat)->NSAttributedString{
        let _font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let fontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: self)
        fullString.addAttributes(fontAttribute, range: range)
        return fullString
    }
}


//Adding Styles to exisiting Attributed String

public extension NSAttributedString{
    
    func with(fontSize:CGFloat)->NSAttributedString{
        
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        var originalFont:UIFont?
        for attr in originalAttributes {
            if let thisFont = attr.value as? UIFont{
                originalFont = thisFont
            }
        }
        let symTraits = originalFont?.fontDescriptor.symbolicTraits
        let differentSizeFont = UIFont(descriptor: originalFont!.fontDescriptor.withSymbolicTraits(symTraits ?? [])!, size: fontSize)
        let fontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: differentSizeFont]
        fontAttribute.forEach { (k,v) in originalAttributes[k] = v }
        let newString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return newString
        
    }
    
    func modify(text:String)->NSAttributedString{
        let originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        let newString = NSAttributedString(string: text, attributes: originalAttributes)
        return newString
    }
    
    func bold()->NSAttributedString{
        
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        var originalFont:UIFont?
        for attr in originalAttributes {
            if let thisFont = attr.value as? UIFont{
                originalFont = thisFont
            }
        }
        
        var symTraits = originalFont?.fontDescriptor.symbolicTraits
        symTraits?.insert([.traitBold])
        
        let boldFont = UIFont(descriptor: originalFont!.fontDescriptor.withSymbolicTraits(symTraits ?? [])!, size: originalFont!.pointSize)
        let fontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        fontAttribute.forEach { (k,v) in originalAttributes[k] = v }
        let newString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return newString
    }
    
    func italic()->NSAttributedString{
        
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        var originalFont:UIFont?
        for attr in originalAttributes {
            if let thisFont = attr.value as? UIFont{
                originalFont = thisFont
            }
        }
        var symTraits = originalFont?.fontDescriptor.symbolicTraits
        symTraits?.insert([.traitItalic])
        let italicFont = UIFont(descriptor: originalFont!.fontDescriptor.withSymbolicTraits(symTraits ?? [])!, size: originalFont!.pointSize)
        let fontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: italicFont]
        fontAttribute.forEach { (k,v) in originalAttributes[k] = v }
        let newString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return newString
    }
    
    func underline()->NSAttributedString{
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        underlineAttribute.forEach { (k,v) in originalAttributes[k] = v }
        let underlineAttributedString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return underlineAttributedString
    }
    
    func align(_ alignment:NSTextAlignment)->NSAttributedString{
        
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        var originalParagraphStyle = NSMutableParagraphStyle()
        for a in originalAttributes{
            if a.value is NSMutableParagraphStyle{
                originalParagraphStyle = a.value as! NSMutableParagraphStyle
            }
        }
        originalParagraphStyle.alignment = alignment
        let paragraphAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.paragraphStyle: originalParagraphStyle]
        paragraphAttribute.forEach { (k,v) in originalAttributes[k] = v }
        
        
        let alignedAttributedString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return alignedAttributedString
        
    }
    
    func lineSpaceOf(_ space:Int)->NSAttributedString{
        
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        var originalParagraphStyle = NSMutableParagraphStyle()
        for a in originalAttributes{
            if a.value is NSMutableParagraphStyle{
                originalParagraphStyle = a.value as! NSMutableParagraphStyle
            }
        }
        originalParagraphStyle.lineSpacing = CGFloat(space)
        let paragraphAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.paragraphStyle: originalParagraphStyle]
        paragraphAttribute.forEach { (k,v) in originalAttributes[k] = v }
        
        
        let alignedAttributedString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return alignedAttributedString
        
    }
    
    func color(with _color:UIColor)->NSAttributedString{
        var originalAttributes = self.attributes(at: 0, effectiveRange: nil)
        let colorAttribute = [NSAttributedString.Key.foregroundColor: _color]
        colorAttribute.forEach { (k,v) in originalAttributes[k] = v }
        let underlineAttributedString = NSAttributedString(string: self.string, attributes: originalAttributes)
        return underlineAttributedString
    }
    
    
    
}

public extension Array where Element:NSAttributedString{
    
    
    func createUnorderedList(tabSpaceBefore:Int? = 0,tabSpaceAfter:Int? = 2)->NSAttributedString{
        
        let originalAttributes = self[0].attributes(at: 0, effectiveRange: nil)
        var originalFont:UIFont = UIFont.systemFont(ofSize: 14)
        for attr in originalAttributes {
            if let thisFont = attr.value as? UIFont{
                originalFont = thisFont
            }
        }
        
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: originalAttributes)
        
        for (index,string) in self.enumerated(){
            
            let bulletPoint: NSAttributedString = (" ".repeatString(forTimes: tabSpaceBefore ?? 0) + "\u{2022}\((" ").repeatString(forTimes: tabSpaceAfter ?? 2))").with(fontSize: originalFont.pointSize)
            let attributedString: NSMutableAttributedString =  bulletPoint +  string as! NSMutableAttributedString
            
            if (index != (self.count - 1)){attributedString.append("\n\n".toAttributedStr())}
            
            
            let paragraphStyle = createParagraphAttribute(withspacing: (NSString(string: bulletPoint.string + " ")).size(withAttributes: originalAttributes).width,tabSpaceAfterBullet: CGFloat(tabSpaceAfter ?? 2))//something weird happends if no empty space added
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    func createOrderedList(tabSpaceBefore:Int? = 0,tabSpaceAfter:Int? = 2)->NSAttributedString{
        
        let originalAttributes = self[0].attributes(at: 0, effectiveRange: nil)
        var originalFont:UIFont = UIFont.systemFont(ofSize: 14)
        for attr in originalAttributes {
            if let thisFont = attr.value as? UIFont{
                originalFont = thisFont
            }
        }
        
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: originalAttributes)
        
        for (index,string) in self.enumerated(){
            
            let bulletPoint: NSAttributedString = (" ".repeatString(forTimes: tabSpaceBefore ?? 0) + "\(index+1). \((" ").repeatString(forTimes: tabSpaceAfter ?? 2))").with(fontSize: originalFont.pointSize)
            let attributedString: NSMutableAttributedString =  bulletPoint +  string as! NSMutableAttributedString
            
            if (index != (self.count - 1)){attributedString.append("\n\n".toAttributedStr())}
            
            
            let paragraphStyle = createParagraphAttribute(withspacing: (NSString(string: bulletPoint.string + " ")).size(withAttributes: originalAttributes).width,tabSpaceAfterBullet: CGFloat(tabSpaceAfter ?? 2))//something weird happends if no empty space added
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    
    
    
    private func createParagraphAttribute(withspacing _space:CGFloat,tabSpaceAfterBullet tabSpaceAfter:CGFloat) ->NSParagraphStyle{
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.defaultTabInterval = _space
        paragraphStyle.headIndent = _space + tabSpaceAfter + 2.1 //add 2.1 to kinda balance out some weird spacing on the first line
        return paragraphStyle
    }
    
}


//Miscellaneous
public extension String{
    
    func toAttributedStr()->NSAttributedString{
        let result = NSAttributedString(string: self)
        return result
    }
}

public extension Array where Element == String{
    
    func toAttributedStrs()->[NSAttributedString]{
        return self.compactMap({$0.toAttributedStr()})
    }
}


public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

////////////// These two extensions below are used to implement list generation above ///////////

extension Int{
    
    func timesString(function:()->()){
        for _ in 0..<self{
            function()
        }
    }
}

extension String{
    
    func repeatString(forTimes _times:Int)->String{
        var newString = ""
        _times.timesString {
            newString += self
        }
        return newString
    }
}

