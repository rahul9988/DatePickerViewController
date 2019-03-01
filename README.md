# DatePickerViewController
DatePickerViewController that gives a feel of UIAlertView


<h3 align="center">
<img src="demo.gif" alt="Screenshot of Quick Chat for iOS" />
</h3>

### Usage
1. Add DatePickerVC class to your project.
2. Create DatePickerVC instance and.
```swift
let datePickerVC = DatePickerVC(title: "Select a Date", pickTitle: "Select", cancelTitle: "Cancel", completion: { (date, canceled) in
           print(d.string())
        }, delegate:self)
self.present(datePickerVC, animated: true, completion: nil)
```
