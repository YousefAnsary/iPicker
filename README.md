<!-- ![iPickerL.png](https://raw.githubusercontent.com/YousefAnsary/iPicker/master/Imgs/iPickerL.png) <br/> -->
# *iPicker*
## *Animated elegant easy to use data&amp; date pickers*

![iPickerL.png](https://raw.githubusercontent.com/YousefAnsary/iPicker/master/Imgs/iPicker.gif) <br/>

------------------------------------------------
### *Installation* ### 
<br/>

**Cocoapod** 

<br/>

```
pod 'IPicker', :git => 'https://github.com/YousefAnsary/iPicker.git'
```
<br/>

**Swift Package Manager**

<br/>

```
.package(url: "https://github.com/YousefAnsary/iPicker.git", from: "2.0.1")
```

<br/>

------------------------------------------------

### ***Usage*** <br/>
#### iPicker now comes with four style options: <br/>

| Style  | Explanation |
| :------------: |:---------------:|
|  dark  | Comes in a dark bakground with white texts |
|  light | Comes in a white bakground with black texts |
|  autoLight | adapts to user's interface style,if iOS < 12 it is light |
|  autoDark | adapts to user's interface style, if iOS < 12 it is dark |

<br/>

***Data Pickers***

<br/>

```
import UIKit
import IPicker

func presentPicker() {
  let picker = IPicker.BottomViewDataPicker(style: .light)
  // let picker = IPicker.FullViewPicker(style: .dark)
  // let picker IPicker.FullViewMultiSelectionPicker(style: .autoDark)
     
  let objArray = [SomeClassOrStruct(aStringVar: "Option", ...), ...]
                     
  picker.setData(data: objArray, key: \.aStringVar)
      
  // OR
  let stringArray = ["Some", "Dummy", "Data"]
  picker.setData(data: stringArray)
      
  //To change initial seleted value
  //For Single Selectors
  picker.selectedIndex = 2 // It is zero by Default
      
  //For Multi Selector
  picker.selectedIndexes = [1, 3] // Empty by Default
  //
      
  picker.didSelect { selectedIndex in }
  picker.didCancelled { }
      
  picker.show(inView: self.view)
}
```

<br/> 

-------------------------------- 

<br/>

***Date Picker***
 
```
import UIKit
import IPicker
     
func presentDatePicker() {
  let picker = IPicker.BottomViewDatePicker(style: .autoLight, pickerMode: .dateAndTime)
  picker.minimumDate = Date() // It is nil by default
  picker.maximumDate = Date() //It is nil by default
  picker.selectedDate = Date() //Initial selected date, It is current date by default
  
  picker.didSelect { selectedDate in }
  picker.didCancelled { }
      
  picker.show(inView: self.view)
}
```
