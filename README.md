![iPickerL.png](https://raw.githubusercontent.com/YousefAnsary/iPicker/master/Imgs/iPickerL.png) <br/>
# *iPicker*
## *Animated elegant easy to use data&amp; date picker*
------------------------------------------------
![iPicker.png](https://raw.githubusercontent.com/YousefAnsary/iPicker/master/Imgs/iPicker.png) <br/>
### *Installation* ###
Add this line to your pod file and run pod install
```javascript
pod 'IPicker', :git => 'https://github.com/YousefAnsary/iPicker.git'
```
<br/>

### ***Usage*** <br/> <br/>
#### iPicker comes in two classes: <br/>
***1: IDataPicker*** <br/>
and it can be used in two ways: <br/>
1: By Passing array of objects and passing the KeyPath of the string variable you are going to display like below:

```javascript
import UIKit
import IPicker

class ViewController: UIViewController {
  
  let picker = IDataPicker()
  
  override func viewDidLoad() {
     super.viewDidLoad()
     
     let objArray = [YourClassOrStruct(stringVar: "Some", intVar: 0, anyVar: nil),
                     YourClassOrStruct(stringVar: "Dummy", intVar: 1, anyVar: nil),
                     YourClassOrStruct(stringVar: "Data", intVar: 2, anyVar: nil)]
     
     picker.setData(data: objArray, key: \.stringVar)
     
  }

}
```

Or <br/>
2-just passing an array of strings like below:

```javascript
import UIKit
import IPicker

class ViewController: UIViewController {
  
  let picker = IDataPicker()
  
  override func viewDidLoad() {
     super.viewDidLoad()
     
     let stringArray = ["Some", "Other", "Dummy", "Data"]
       
     picker.setData(data: stringArray)
  }

}
```
And simply call:

```javascript
picker.show(inView: self.view)
```
<br/> ![iPicker.gif](https://raw.githubusercontent.com/YousefAnsary/iPicker/master/Imgs/iPicker.gif) <br/>
And to access selected index: 
```javascript
picker.selectedIndex
```
And you can listen for events easily via:
```javascript
picker.onDoneBtnTapped { selectedIndex in
  print(selectedIndex)
}

picker.onValueChanged { selectedIndex in
  print(selectedIndex)
}

picker.onCancelled {
  print("Cancelled")
}
```
The Second Class is <br/>
***2- IDatePicker***
 
```javascript
import UIKit
import IPicker

class ViewController: UIViewController {
  
  let picker = IDatePicker()
  
  override func viewDidLoad() {
     super.viewDidLoad()
     
     //YDatePicker Customization
     picker.pickerMode = UIDatePicker.Mode.dateAndTime //it is dateAndTime by default
     picker.minimumDate = Date() // It is nil by default
     picker.maximumDate = Date() //It is nil by default
     
  }

}
```
To get the selected date:
```javascript
picker.selectedDate
```
And similarly listen for events :
```javascript
picker.onDoneBtnTapped { selectedDate in
  print("Date Changed")
}

picker.onCancelled {
  print("Cancelled")
}
```
show method just like the other <br/>
```javascript
picker.show(inView: self.view)
```
<br/>Some common customizations <br/>
```javascript
  picker.seletorColor: UIColor = .lightGray // lightGray is the default
  picker.fontColor: UIColor = .black // black is the default
  picker.doneBtnTitle = "Done" //"Done" is the default 
  picker.doneTextColor = UIColor.blue
  picker.pickerBackgroundColor = UIColor.white //default is off white
```
**Special Thanks to My Friend: Amr Khalifa**
