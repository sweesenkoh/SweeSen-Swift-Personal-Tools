//
//  ExtensionsUIView.swift
//  SweeSenTools
//
//  Created by Koh Sweesen on 27/7/19.
//  Copyright © 2019 Koh Swee Sen. All rights reserved.
//

import UIKit




import UIKit


public extension UIView{
    
    func setFrame<T:UIView>(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat)->T{
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        return self as! T
    }
    
    func setBackgroundColor<T:UIView>(color:UIColor)->T{
        self.backgroundColor = color
        return self as! T
    }
    
    func setTextViewText<T:UITextView,U>(text:U)->T{
        
        if type(of: U.self) == type(of: String.self){
            (self as! T).text = text as? String
        }
            
        else if type(of: U.self) == type(of: NSAttributedString.self){
            (self as! T).attributedText = text as? NSAttributedString
        }
        else{
            fatalError("Only String or NSAttributedString can be passed into setText() function")
        }
        return self as! T
    }
    
    
    func setLabelText<T:UILabel,U>(text:U)->T{
        
        if type(of: U.self) == type(of: String.self){
            (self as! T).text = text as? String
        }
        else if type(of: U.self) == type(of: NSAttributedString.self){
            (self as! T).attributedText = text as? NSAttributedString
        }
        else{
            fatalError("Only String or NSAttributedString can be passed into setText() function")
        }
        return self as! T
    }
    
    enum Anchors {
        case leftAnchor
        case rightAnchor
        case topAnchor
        case bottomAnchor
        case heightAnchor
        case widthAnchor
        case centerXAnchor
        case centerYAnchor
    }
    
    func setConstraint<T:UIView,U>(of originAnchor:UIView.Anchors, on destinationAnchor:U, padding spacing:CGFloat = 0, multiplier:CGFloat = 1,widthConstant:CGFloat? = nil, heightConstant:CGFloat? = nil)->T{
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if originAnchor == .leftAnchor || originAnchor == .rightAnchor{
            if originAnchor == .leftAnchor{
                self.leftAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: spacing).isActive = true
            }else{
                self.rightAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: -spacing).isActive = true
            }
        }
        else if originAnchor == .topAnchor || originAnchor == .bottomAnchor{
            if originAnchor == .topAnchor{
                self.topAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: spacing).isActive = true
            }else{
                self.bottomAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: -spacing).isActive = true
            }
        }
        else if originAnchor == .heightAnchor || originAnchor == .widthAnchor{
            if originAnchor == .heightAnchor{
                if let heightConstant = heightConstant{
                    self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
                }
                else{
                    self.heightAnchor.constraint(equalTo: destinationAnchor as! NSLayoutDimension, multiplier: multiplier).isActive = true
                }
                
            }else{
                if let widthConstant = widthConstant{
                    self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
                }
                else{
                    self.widthAnchor.constraint(equalTo: destinationAnchor as! NSLayoutDimension, multiplier: multiplier).isActive = true
                }
            }
        }
            
        else if originAnchor == .centerXAnchor || originAnchor == .centerYAnchor{
            if originAnchor == .centerXAnchor{
                self.centerXAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>).isActive = true
            }else{
                self.centerYAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor> as! NSLayoutAnchor<NSLayoutYAxisAnchor>).isActive = true
            }
        }
        else{
            fatalError("Wrong constraint anchor passed")
        }
        return self as! T
    }
    
    func addView<T:UIView>(to toView: UIView)-> T{
        toView.addSubview(self)
        return self as! T
    }
    
    func addNewSubview<T:UIView>(subView:UIView)->T{
        self.addSubview(subView)
        return self as! T
    }
    
    func setAlpha<T:UIView>(alphaValue:CGFloat)->T{
        self.alpha = alphaValue
        return self as! T
    }
    
    func setCornerRadius<T:UIView>(value:CGFloat)->T{
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
        return self as! T
    }
    

    
    func setButtonTitle<T:UIButton,U>(text:U,state:UIButton.State)->T{
        
        if type(of: U.self) == type(of: String.self){
            (self as! T).setTitle(text as? String, for: state)
        }
        else if type(of: U.self) == type(of: NSAttributedString.self){
            (self as! T).setAttributedTitle(text as? NSAttributedString, for: state)
        }
        else{
            fatalError("Only String or NSAttributedString can be passed into setButtonTitle() function")
        }
        
        return (self as! T)
    }
}

public extension UIImageView{
    
    func setUIImage(named: String, renderingMode:UIImage.RenderingMode? = nil)->UIImageView{
        self.image = UIImage(named: named)?.withRenderingMode(renderingMode ?? .alwaysOriginal)
        return self
    }
    
    func setImageTintColor(color:UIColor)->UIImageView{
        self.tintColor = color
        return self
    }
    
    func setContentMode(_ contentMode:UIView.ContentMode)->UIImageView{
        self.contentMode = contentMode
        return self
    }
    
}



public class ClosureSleeve{
    let closure: () -> ()
    
    init(_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke(){
        closure()
    }
}

public extension UIControl{
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()){
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(sleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

public extension UIGestureRecognizer{
    func addAction(_ closure: @escaping ()->()){
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(sleeve.invoke))
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}


open class BaseTableViewController<T,U:BaseTableCell<T>>:UITableViewController{
    
    open var baseDataSource:Array<T>!{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    public var cellOnclick:(_ indexPath:IndexPath)->() = {_ in }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(U.self, forCellReuseIdentifier: "cellid")
        setupView()
    }
    
    open func setupView(){
        
    }
    
    
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseDataSource.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! U
        cell.baseDataSource = baseDataSource[indexPath.row]
        return cell
    }
    
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellOnclick(indexPath)
    }
    
}


open class BaseTableCell<T>:UITableViewCell{
    
    open var baseDataSource:T!{
        didSet{
            setupCell()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    open func setupCell(){
        
        //this is meant to be overwritten
        self.textLabel?.text = baseDataSource as? String
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//here is how to use this

//class MyTableController:BaseTableViewController<String, MyTableCell>{
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.baseDataSource = []
//
//        for number in 1...100{
//            self.baseDataSource.append(String(number))
//        }
//    }
//}
//
//class MyTableCell:BaseTableCell<String>{
//
//    override func setupCell() {
//        self.backgroundColor = .orange
//        self.textLabel?.attributedText = self.baseDataSource.with(fontSize: 20).color(with: .white).bold().align(.left)
//    }
//}





open class SlideOutMenuView:UIView{
    
    public var slideInMenuOut = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    open func setupView(){
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func panFunction(gesture:UIPanGestureRecognizer,originView:UIView){

        let menuFrame = self.frame
        let translation = gesture.translation(in: originView).x
        let transform = (translation > self.frame.width) ? self.frame.width : translation
        self.frame = CGRect(x: (translation < 0 && slideInMenuOut) ?
            transform :
            (translation >= 0 && !slideInMenuOut) ?
                (transform - menuFrame.width) :
            menuFrame.minX, y: 0, width: menuFrame.width, height: menuFrame.height)
        
        if (gesture.state == .ended){
            let menuXMidValue = self.frame.midX
            slideInMenuOut = (menuXMidValue > 0) ? true : false
            UIView.animate(withDuration: 0.2) {
                self.frame = CGRect(x: (menuXMidValue > 0) ? 0 : -menuFrame.width, y: 0, width: menuFrame.width, height: menuFrame.height)
            }
        }
        
    }
    
    open func animateMenuSlideByButton(){
        
        let opening = self.frame.maxX <= 0
        let frameWidth = self.frame.width
        let frameHeight = self.frame.height
    
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: opening ? 0 : -frameWidth, y: 0, width: frameWidth, height: frameHeight)
        }) { (true) in
            self.slideInMenuOut = opening
        }
    }
    
    
}



//
//
//public extension UIView{
//
//    func setFrame<T:UIView>(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat)->T{
//        self.frame = CGRect(x: x, y: y, width: width, height: height)
//        return self as! T
//    }
//
//    func setBackgroundColor<T:UIView>(color:UIColor)->T{
//        self.backgroundColor = color
//        return self as! T
//    }
//
//    func setTextViewText<T:UITextView,U>(text:U)->T{
//
//        if type(of: U.self) == type(of: String.self){
//            (self as! T).text = text as? String
//        }
//
//        else if type(of: U.self) == type(of: NSAttributedString.self){
//            (self as! T).attributedText = text as? NSAttributedString
//        }
//        else{
//            fatalError("Only String or NSAttributedString can be passed into setText() function")
//        }
//        return self as! T
//    }
//
//
//    func setLabelText<T:UILabel,U>(text:U)->T{
//
//        if type(of: U.self) == type(of: String.self){
//            (self as! T).text = text as? String
//        }
//        else if type(of: U.self) == type(of: NSAttributedString.self){
//            (self as! T).attributedText = text as? NSAttributedString
//        }
//        else{
//            fatalError("Only String or NSAttributedString can be passed into setText() function")
//        }
//        return self as! T
//    }
//
//    enum Anchors {
//        case leftAnchor
//        case rightAnchor
//        case topAnchor
//        case bottomAnchor
//        case heightAnchor
//        case widthAnchor
//        case centerXAnchor
//        case centerYAnchor
//    }
//
//    func setConstraint<T:UIView,U>(of originAnchor:Anchors, on destinationAnchor:U, padding spacing:CGFloat = 0, multiplier:CGFloat = 1,widthConstant:CGFloat? = nil, heightConstant:CGFloat? = nil)->T{
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//        if originAnchor == .leftAnchor || originAnchor == .rightAnchor{
//            if originAnchor == .leftAnchor{
//                self.leftAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: spacing).isActive = true
//            }else{
//                self.rightAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: -spacing).isActive = true
//            }
//        }
//        else if originAnchor == .topAnchor || originAnchor == .bottomAnchor{
//            if originAnchor == .topAnchor{
//                self.topAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: spacing).isActive = true
//            }else{
//                self.bottomAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: -spacing).isActive = true
//            }
//        }
//        else if originAnchor == .heightAnchor || originAnchor == .widthAnchor{
//            if originAnchor == .heightAnchor{
//                if let heightConstant = heightConstant{
//                    self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
//                }
//                else{
//                    self.heightAnchor.constraint(equalTo: destinationAnchor as! NSLayoutDimension, multiplier: multiplier).isActive = true
//                }
//
//            }else{
//                if let widthConstant = widthConstant{
//                    self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
//                }
//                else{
//                    self.widthAnchor.constraint(equalTo: destinationAnchor as! NSLayoutDimension, multiplier: multiplier).isActive = true
//                }
//            }
//        }
//
//        else if originAnchor == .centerXAnchor || originAnchor == .centerYAnchor{
//            if originAnchor == .centerXAnchor{
//                self.centerXAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor>).isActive = true
//            }else{
//                self.centerYAnchor.constraint(equalTo: destinationAnchor as! NSLayoutAnchor<NSLayoutXAxisAnchor> as! NSLayoutAnchor<NSLayoutYAxisAnchor>).isActive = true
//            }
//        }
//        else{
//            fatalError("Wrong constraint anchor passed")
//        }
//        return self as! T
//    }
//
//    func addView<T:UIView>(to toView: UIView)-> T{
//        toView.addSubview(self)
//        return self as! T
//    }
//
//    func addNewSubview<T:UIView>(subView:UIView)->T{
//        self.addSubview(subView)
//        return self as! T
//    }
//
//    func setAlpha<T:UIView>(alphaValue:CGFloat)->T{
//        self.alpha = alphaValue
//        return self as! T
//    }
//
//    func setCornerRadius<T:UIView>(value:CGFloat)->T{
//        self.layer.cornerRadius = value
//        return self as! T
//    }
//
//
//
//    func setButtonTitle<T:UIButton,U>(text:U,state:UIButton.State)->T{
//
//        if type(of: U.self) == type(of: String.self){
//            (self as! T).setTitle(text as? String, for: state)
//        }
//        else if type(of: U.self) == type(of: NSAttributedString.self){
//            (self as! T).setAttributedTitle(text as? NSAttributedString, for: state)
//        }
//        else{
//            fatalError("Only String or NSAttributedString can be passed into setButtonTitle() function")
//        }
//
//        return (self as! T)
//    }
//}
//
//public extension UIImageView{
//
//    func setUIImage(named: String)->UIImageView{
//        self.image = UIImage(named: named)
//        return self
//    }
//
//    func setContentMode(_ contentMode:UIView.ContentMode)->UIImageView{
//        self.contentMode = contentMode
//        return self
//    }
//
//}
//
//
//
//public class ClosureSleeve{
//    let closure: () -> ()
//
//    init(_ closure: @escaping ()->()) {
//        self.closure = closure
//    }
//
//    @objc func invoke(){
//        closure()
//    }
//}
//
//public extension UIControl{
//    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()){
//        let sleeve = ClosureSleeve(closure)
//        addTarget(sleeve, action: #selector(sleeve.invoke), for: controlEvents)
//        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//    }
//}
//
//public extension UIGestureRecognizer{
//    func addAction(_ closure: @escaping ()->()){
//        let sleeve = ClosureSleeve(closure)
//        addTarget(sleeve, action: #selector(sleeve.invoke))
//        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//    }
//}
//
//
//open class BaseTableViewController<T,U:BaseTableCell<T>>:UITableViewController{
//
//    open var baseDataSource:Array<T>!{
//        didSet{
//            self.tableView.reloadData()
//        }
//    }
//
//    public var cellOnclick:(_ indexPath:IndexPath)->() = {_ in }
//
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.register(U.self, forCellReuseIdentifier: "cellid")
//        setupView()
//    }
//
//    open func setupView(){
//
//    }
//
//
//
//    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return baseDataSource.count
//    }
//
//    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! U
//        cell.baseDataSource = baseDataSource[indexPath.row]
//        return cell
//    }
//
//
//    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.cellOnclick(indexPath)
//    }
//
//}
//
//
//open class BaseTableCell<T>:UITableViewCell{
//
//    open var baseDataSource:T!{
//        didSet{
//            setupCell()
//        }
//    }
//
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    open func setupCell(){
//
//        //this is meant to be overwritten
//        self.textLabel?.text = baseDataSource as? String
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//
////here is how to use this
//
////class MyTableController:BaseTableViewController<String, MyTableCell>{
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        self.baseDataSource = []
////
////        for number in 1...100{
////            self.baseDataSource.append(String(number))
////        }
////    }
////}
////
////class MyTableCell:BaseTableCell<String>{
////
////    override func setupCell() {
////        self.backgroundColor = .orange
////        self.textLabel?.attributedText = self.baseDataSource.with(fontSize: 20).color(with: .white).bold().align(.left)
////    }
////}
//
//
//
//
//
//open class SlideOutMenuView:UIView{
//
//    public var slideInMenuOut = false
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    open func setupView(){
//
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    open func panFunction(gesture:UIPanGestureRecognizer,originView:UIView){
//
//        let menuFrame = self.frame
//        let translation = gesture.translation(in: originView).x
//        let transform = (translation > self.frame.width) ? self.frame.width : translation
//        self.frame = CGRect(x: (translation < 0 && slideInMenuOut) ?
//            transform :
//            (translation >= 0 && !slideInMenuOut) ?
//                (transform - menuFrame.width) :
//            menuFrame.minX, y: 0, width: menuFrame.width, height: menuFrame.height)
//
//        if (gesture.state == .ended){
//            let menuXMidValue = self.frame.midX
//            slideInMenuOut = (menuXMidValue > 0) ? true : false
//            UIView.animate(withDuration: 0.2) {
//                self.frame = CGRect(x: (menuXMidValue > 0) ? 0 : -menuFrame.width, y: 0, width: menuFrame.width, height: menuFrame.height)
//            }
//        }
//
//    }
//
//    open func animateMenuSlideByButton(){
//
//        let opening = self.frame.maxX <= 0
//        let frameWidth = self.frame.width
//        let frameHeight = self.frame.height
//
//
//        UIView.animate(withDuration: 0.3, animations: {
//            self.frame = CGRect(x: opening ? 0 : -frameWidth, y: 0, width: frameWidth, height: frameHeight)
//        }) { (true) in
//            self.slideInMenuOut = opening
//        }
//    }
//
//
//}


