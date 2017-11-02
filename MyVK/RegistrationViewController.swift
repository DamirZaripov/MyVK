import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registrationScrollView: UIScrollView!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var dateBirthdayPickerTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        prepareNotifications()
    }
    
    //MARK: - Data Picker
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateBirthdayPickerTextField.inputAccessoryView = toolbar
        dateBirthdayPickerTextField.inputView = datePicker
    }
    
    @objc func donePressed() {
        
        let dateBirthdayFormatter = DateFormatter()
        dateBirthdayFormatter.dateStyle = .medium
        dateBirthdayFormatter.timeStyle = .none
        
        dateBirthdayPickerTextField.text =  dateBirthdayFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    //MARK: - Scroll & Keybord methods
    
    func prepareNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
 
    @objc func keyboardWillShow(notification: NSNotification) {
        if var userInfo = notification.userInfo {
            var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            var contentInset:UIEdgeInsets = self.registrationScrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            registrationScrollView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        registrationScrollView.contentInset = .zero
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
