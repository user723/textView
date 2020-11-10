//
//  ViewController.swift
//  TextView
//
//  Created by Onur on 06.11.20.
//

import UIKit
import SwiftRichString

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var myTextView: UITextView!
    
    var boldFont = false
    var bodyHTML = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.delegate = self
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let boldButton = UIBarButtonItem(image: UIImage(named: "bold"), style: .plain, target: self, action: #selector(boldButtonKeyboardClicked))
        keyboardToolbar.items = [boldButton]
        myTextView.inputAccessoryView = keyboardToolbar
        
        myTextView.becomeFirstResponder()
    }
    
    @objc func boldButtonKeyboardClicked() {
        if boldFont == false {
            boldFont = true
        } else {
            boldFont = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let baseStyle = Style {
            $0.font = UIFont.systemFont(ofSize: 14)
        }

        let boldStyle = Style {
            $0.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        let groupStyle = StyleXML.init(base: baseStyle, ["b" : boldStyle])
        
        
        if boldFont == false {
            bodyHTML.append(text)
        } else {
            bodyHTML.append("<b>" + text + "</b>")
        }
        
        DispatchQueue.main.async {
            self.myTextView?.attributedText = self.bodyHTML.set(style: groupStyle)
        }
        
        return false
    }
    
}

