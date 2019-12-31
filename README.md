# SweeSen Swift Personal Tools

These are some of the useful extensions to make some process of IOS development easier and faster. This framework mainly consists of extensions of the two following area:

* String Extentions
* UIView Extentions 

</br>

# String Extensions 

Usually when we attempt to change any text properties of UILabel or UITextView, there are quite a lot of lines of code written just to change a few properties of the text, such as text size, text color and so on. Below is one example of code setting up UILabel:

```swift 

let label : UILabel = {
  let l = UILabel()
  l.text = "Hello World"
  l.textColor = .blue
  l.font = l.font.withSize(25)
  l.textAlignment = .center
  
  //maybe more code to set font to bold, italics, or underline...
  
  return l
}()

```
For the string extensions in this framework, everything is first converted into NSAttributedString, then doing all the manipulations on the string. Afterwards, we then assign our attributedString to the attributedString property of the UILabel or UITextView. 

</br>
Below is an example:

```swift 

let label : UILabel = {
  let l = UILabel()
  l.attributedString = "Hello World"
      .with(fontSize: 25)
      .color(with: .blue)
      .align(.center)
      .bold()
      .italic()
      
  return l
}()

```

This provide a simplified solution to setting text properties on UILabel or UITextView. Previously, while UILabel or UITextView allows user to set properties such as text color, font and text alignment, for other properties such as italic or underline, it could not be achieved unless we create an NSAttributedString instance and set it to the UILabel or UITextView. 

Therefore, this extensions helps to simplify and shorten the code on setting text properties on the UILabel or UITextView.

Below are all the extensions functions that are available in this framework

```swift

//to be updated in future 

```


## Creating Ordered List or Unordered List

To create an unordered list in UITextView, such as this one below: 
* Item 1
* Item 2
* Item 3

We can achieve this in code as shown below:  

```swift

["Item 1", "Item 2" , "Item 3"].toAttributedStrs().createUnorderedList().with(fontSize: 16)

```

We can customise the amount of spaces that is before the bullet point, or after the bullet point, by specifying it as the parameter.

```swift

["Item 1", "Item 2" , "Item 3"].toAttributedStrs().createUnorderedList(tabSpaceBefore: 2 , tabSpaceAfter: 3)

```

Since the style used throughout the app is most likely the same, we can create another extensions to make the process of creating lists easier. 

```swift

extension Array where Element:String{

  func ul(){ //unordered list
    return self
      .toAttributedStrs()
      .createUnorderedList(tabSpaceBefore: 2 , tabSpaceAfter: 3)
      .color(with: .blue)
      .with(fontSize: 12)
  }

}

//now we can simply call ul() on [String]
["Item 1", "Item 2" , "Item 3"].ul()


//We can still customise any of the properties, for example
["Item 1", "Item 2" , "Item 3"].ul().color(with: .black).bold()

```

</br></br></br>

# UIView Extensions

## 1. Easier constraints layout
Laying out views using constraint layout usually involves a lot of code. There are many different ways of coding out, below is a typical example:

```swift

let backgroundView:UIView = {

  let backgroundView = UIView()
  backgroundView.backgroundColor = .blue
  return backgroundView

}()


func addBackgroundView(){
  
  view.addSubView(backgroundView)
  backgroundView.translateAutoResizingMasksIntoConstraints = false
  backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
  backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
  backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
  backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
}

```
</br>

With the extensions on UIView in this tool, laying out UIViews will be a much easier process. Here is the same process done with the use of the extensions:

```swift

func addBackgroundView(){

  backgroundView = UIView()
    .color(with: .blue)
    .addView(to: self.view)
    .setConstraint(of: .topAnchor, on: view.topAnchor, padding: 4)
    .setConstraint(of: .heightAnchor, on: view.heightAnchor, multiplier: 0.3)
    .setConstraint(of: .leftAnchor, on: view.leftAnchor, padding: 15)
    .setConstraint(of: .rightAnchor, on: view.rightAnchor, padding: 12)
}
```


