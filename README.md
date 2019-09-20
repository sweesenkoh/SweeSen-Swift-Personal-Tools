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
  l.attributedString = "Hello World".with(fontSize: 25).color(with: .blue).align(.center).bold().italic()
  return l
}()

```

This provide a simplified solution to setting text properties on UILabel or UITextView. Previously, while UILabel or UITextView allows user to set properties such as text color, font and text alignment, for other properties such as italic or underline, it could not be achieved unless we create an NSAttributedString instance and set it to the UILabel or UITextView. 

Therefore, this extensions helps to simplify and shorten the code on setting text properties on the UILabel or UITextView.

Below are all the extensions functions that are available in this framework

```swift

somethings

```


## Creating Ordered List or Unordered List

