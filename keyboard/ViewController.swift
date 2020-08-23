

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    
    // this identify textfield active.
    var activeField: UITextField?
    
    @IBOutlet var textField1: UITextField!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField1.delegate = self
        
        let viewtap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissing))
        
        view.addGestureRecognizer(viewtap)
        
        // this notify keyboard show and hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    
    }
    
    // keyboard when show
    @objc func keyboardwillShown(notification: NSNotification){
        
        // scrollview enable
        self.scrollView.isScrollEnabled = true
        // notify keyboard
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        // edges and height of keyboard to scrollview according to it.
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    // keyboard when hidden
    
    @objc func keyboardWillHide(notification: NSNotification){
        
        
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        
        // scrollview will disable
        self.scrollView.isScrollEnabled = false
    }
    
    // textfield did editing
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    // textendediting
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }

    
    @objc func dismissing()
    {
        self.view.endEditing(true)
        
    }
    
    
    
}

