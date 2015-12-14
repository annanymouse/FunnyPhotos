# Keeping spaces out of your searchBar in Swift

Swift has a built-function that can help with this, be sure to add the UISearchBarDelegate as a subclass to your ViewController first:

```objective-c
class ViewController: UIViewController, UISearchBarDelegate {
...
```

Add the following function shouldChangeTextInRange to your code.  Keep in mind that this code is run for each character entered in a search bar.

```objective-c
func searchBar(searchBar: UISearchBar,shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
   \\NSLog(range.location, text)     \\uncomment this line to troubleshoot
   if text.isEmpty {
   return false
   } else {
   return true
   }
}
```

For more information on this method, check out the official documentation:

[](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UISearchBarDelegate_Protocol/index.html#//apple_ref/occ/intfm/UISearchBarDelegate/searchBar:shouldChangeTextInRange:replacementText: "searchBar:shouldChangeTextInRange")
