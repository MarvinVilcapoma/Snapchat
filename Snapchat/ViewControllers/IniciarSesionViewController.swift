//
//  IniciarSesionViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 7/5/20.
//  Copyright © 2020 TecsupDev. All rights reserved.
//

import UIKit
import Firebase

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            print("Intentamos iniciar sesión")
            if(error != nil){
                print ("tenemos el siguiente error: \(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user, error) in
                    print("Intentamos crear un usuario")
                    if(error != nil) {
                        print("Tenemos el siguiente error: \(String(describing: error))")
                    }else {
                        print("El usuario fue creado exitosamente")
                        Database.database().reference().child("usuarios").child((user?.user.uid)!).child("email").setValue(user?.user.email)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            } else {
                print ("Inicio de Sesión exitosa")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
        
    }
    
}

