//
//  File.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import Google
import GoogleSignIn
import SDWebImage

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
	
	var error : NSError?
	
  let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "login")
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
    
    
  let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "logo")
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var usernameTextField: UITextField = {
    let field = UITextField()
    field.backgroundColor = .white
    field.textAlignment = .center
    field.placeholder = "Usuario o correo"
    field.keyboardType = .emailAddress
    field.translatesAutoresizingMaskIntoConstraints = false
    field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
    field.layer.shadowRadius = 2
    field.layer.shadowOpacity = 0.8
    field.layer.shadowOffset = CGSize(width: 0, height: 3)
    field.delegate = self
    return field
  }()
  
  lazy var passwordTextField: UITextField = {
    let field = UITextField()
    field.isSecureTextEntry = true
    field.backgroundColor = .white
    field.textAlignment = .center
    field.placeholder = "Contraseña"
    field.translatesAutoresizingMaskIntoConstraints = false
    field.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
    field.layer.shadowRadius = 2
    field.layer.shadowOpacity = 0.8
    field.layer.shadowOffset = CGSize(width: 0, height: 3)
    field.delegate = self
    return field
  }()
  
  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = GREEN_COLOR
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
    button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
    button.layer.shadowRadius = 2
    button.layer.shadowOpacity = 0.8
    button.layer.shadowOffset = CGSize(width: 0, height: 3)
    return button
  }()
  
  lazy var registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Registrarse", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = DEEP_BLUE_COLOR
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
    button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
    button.layer.shadowRadius = 2
    button.layer.shadowOpacity = 0.8
    button.layer.shadowOffset = CGSize(width: 0, height: 3)
    return button
  }()
	
	lazy var facebookButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Facebook", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.backgroundColor = FACEBOOK_COLOR
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(handleFacebookButton), for: .touchUpInside)
		button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
		button.layer.shadowRadius = 2
		button.layer.shadowOpacity = 0.8
		button.layer.shadowOffset = CGSize(width: 0, height: 3)
		button.alpha = 0
		return button
	}()
	
  lazy var googleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Google+", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = GOOGLE_COLOR
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleGoogleButton), for: .touchUpInside)
    button.layer.shadowColor = UIColor.init(white: 0.5, alpha: 1).cgColor
    button.layer.shadowRadius = 2
    button.layer.shadowOpacity = 0.8
    button.layer.shadowOffset = CGSize(width: 0, height: 3)
		button.alpha = 0
    return button
  }()
	
	lazy var googleSigningButton = GIDSignInButton()
  
  lazy var forgotPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("¿Olvidaste tu contraseña?", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = DEEP_BLUE_COLOR
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
    return button
  }()
	
	let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.activityIndicatorViewStyle = .gray
		indicator.hidesWhenStopped = true
		indicator.clipsToBounds = true
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()
	
	
	//if user is logged in check
	func isKeyPresentInUserDefaults(key: String) -> Bool {
		return UserDefaults.standard.object(forKey: LOGGED_IN) != nil
	}
	
	
	
	
  override func viewDidLoad() {
    super.viewDidLoad()
		
		//redirecting portion if a user is logged in
		if isKeyPresentInUserDefaults(key: LOGGED_IN) {
			if UserDefaults.standard.value(forKey: LOGGED_IN) as! Bool == true{
				if(UserDefaults.standard.value(forKey: USER_ROLE) as! String == "3"){
					self.navigationController?.pushViewController(HomeViewController(), animated: true)
				}
				else{
					self.navigationController?.pushViewController(CompanyHomeViewController(), animated: true)
				}
			}
			else{
				print("User logged out recently")
			}
		}
		else{
			print("User logged out")
		}
		
		
		setupGoogleSigning()
    setupUI()
  }
	
	func setupGoogleSigning(){
		
		GGLContext.sharedInstance().configureWithError(&error)
		if error != nil{
			print(error ?? "Error Occured")
			return
		}
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().delegate = self
	}
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if error != nil{
			print(error ?? "Some error")
			return
		}
		self.registerSocialMediaUser(userName: user.profile.name!, userEmail: user.profile.email!)
	}
	// For hiding and full screening the view starts
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
		super.viewWillAppear(animated)
	}
	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
		super.viewWillDisappear(animated)
	}
	// For hiding and full screening the view ends
	
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    usernameTextField.layer.cornerRadius = usernameTextField.frame.height / 2
    usernameTextField.font = UIFont(name: TEXT_FONT, size: usernameTextField.frame.height * 0.35)
    
    passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
    passwordTextField.font = UIFont(name: TEXT_FONT, size: passwordTextField.frame.height * 0.35)
    
    loginButton.layer.cornerRadius = loginButton.frame.height / 2
    loginButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: loginButton.frame.height * 0.4)
    
    registerButton.layer.cornerRadius = registerButton.frame.height / 2
    registerButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: registerButton.frame.height * 0.4)
    
    facebookButton.layer.cornerRadius = facebookButton.frame.height / 2
    facebookButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: facebookButton.frame.height * 0.4)
    
    googleButton.layer.cornerRadius = googleButton.frame.height / 2
    googleButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: googleButton.frame.height * 0.4)
    
    forgotPasswordButton.titleLabel?.font = UIFont(name: TEXT_FONT, size: googleButton.frame.height * 0.4)
  }
  
  func setupUI() {
    setupBackgroundImageView()
    setupLogoImageView()
    setupUsernameTextField()
    setupPasswordTextField()
    setupLoginButton()
    setupRegisterButton()
    setupFacebookButton() // facebook button is disapeared because its alpha is 0
    setupGoogleButton() // Google button is disapeared because its alpha is 0
    //setupForgotPasswordButton()
		setupActivityIndicator()
  }
  
  func setupBackgroundImageView() {
    view.addSubview(backgroundImageView)
    // constraints
    backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func setupLogoImageView() {
    view.addSubview(logoImageView)
    // constraints
    let width = view.frame.width * 0.55
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    logoImageView.heightAnchor.constraint(equalToConstant: width / 1.43).isActive = true
  }
  
  func setupUsernameTextField() {
    view.addSubview(usernameTextField)
    // constraints
    usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10).isActive = true
    usernameTextField.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
    usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    usernameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupPasswordTextField() {
    view.addSubview(passwordTextField)
    // constraints
    passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
    passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupLoginButton() {
    view.addSubview(loginButton)
    // constraints
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
    loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupRegisterButton() {
    view.addSubview(registerButton)
    // constraints
    registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
    registerButton.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
    registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupFacebookButton() {
    view.addSubview(facebookButton)
    // constraints
    facebookButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10).isActive = true
    facebookButton.leftAnchor.constraint(equalTo: registerButton.leftAnchor).isActive = true
    facebookButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor, multiplier: 0.48).isActive = true
    facebookButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupGoogleButton() {
    view.addSubview(googleButton)
    // constraints
    googleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10).isActive = true
    googleButton.rightAnchor.constraint(equalTo: registerButton.rightAnchor).isActive = true
    googleButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor, multiplier: 0.48).isActive = true
    googleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
  }
  
  func setupForgotPasswordButton() {
    view.addSubview(forgotPasswordButton)
    // constranits
    forgotPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    forgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    forgotPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    forgotPasswordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
  }
	func setupActivityIndicator() {
		
		view.addSubview(activityIndicator)
		// constraints
		activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
		activityIndicator.rightAnchor.constraint(equalTo: loginButton.rightAnchor, constant: -10).isActive = true
	}
	
	//alert fuctions
	func showEmptyFieldAlert(){
		// Create the alert controller
		
		let alertController = UIAlertController(title: "Error", message: "El correo electrónico y la contraseña no pueden estar vacíos", preferredStyle: .alert)
		
		// Create the actions
		let verDetalleAction = UIAlertAction(title: "Está Bien", style: UIAlertActionStyle.default) {
			UIAlertAction in
			print("Okay Pressed")
		}
		
		// Add the actions
		alertController.addAction(verDetalleAction)
		
		// Present the controller
		self.present(alertController, animated: true, completion: nil)
	}
	
	//alert fuctions
	func showInvalidCredentialsAlert(){
		// Create the alert controller
		
		let alertController = UIAlertController(title: "Error", message: "Introducir correo electrónico y contraseña válidos", preferredStyle: .alert)
		
		// Create the actions
		let verDetalleAction = UIAlertAction(title: "Está Bien", style: UIAlertActionStyle.default) {
			UIAlertAction in
			print("Okay Pressed")
		}
		
		// Add the actions
		alertController.addAction(verDetalleAction)
		
		// Present the controller
		self.present(alertController, animated: true, completion: nil)
	}
	
	func handleLoginButton() {
		view.endEditing(true)
		
		if usernameTextField.text == "" || passwordTextField.text == "" {
			self.showEmptyFieldAlert()
			print("you must enter email and password")
			return
		}
		
		guard let email = usernameTextField.text, let password = passwordTextField.text else { return }
		
		let params = ["email": email,
		              "password": password,
		              "device_token" : UserDefaults.standard.value(forKey: DEVICE_TOKEN) as! String,
									"authenticate": "false"] as [String: Any]
		
    guard let url = URL(string: "\(API_URL)login") else { return }
		
		activityIndicator.startAnimating()
		Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { response in
			guard response.result.isSuccess else {
				self.activityIndicator.stopAnimating()
				print(response)
				print(response.error.debugDescription)
				return
			}
			print(response)
			if let responseData = response.data {
				let json = JSON(data: responseData)
				if let dictArray = json.array {
					if dictArray[0]["login_status"] == "failed" {
						self.activityIndicator.stopAnimating()
						self.showInvalidCredentialsAlert()
						print("Login failed. Please insert correct email and password")
					} else {
						self.activityIndicator.stopAnimating()
						print("login successfull")
						UserDefaults.standard.set(true, forKey: LOGGED_IN)
						UserDefaults.standard.set(dictArray[0]["auth_token"].string, forKey: USER_AUTH_TOKEN)
						UserDefaults.standard.set(dictArray[0]["user_id"].string, forKey: USER_ID)
						UserDefaults.standard.set(dictArray[0]["firstname"].string, forKey: FIRST_NAME)
						UserDefaults.standard.set(dictArray[0]["lastname"].string, forKey: LAST_NAME)
						UserDefaults.standard.set(dictArray[0]["user_role"].string, forKey: USER_ROLE)
						UserDefaults.standard.set(dictArray[0]["user_mail"].string, forKey: LOGGED_IN_USER_MAIL)
						UserDefaults.standard.set(dictArray[0]["Celular"].string, forKey: CELULAR)
						UserDefaults.standard.set(dictArray[0]["Telefono_resid"].string, forKey: TELEFONO)
						var userRole : String!
						userRole = UserDefaults.standard.value(forKey: USER_ROLE) as! String
						if(userRole == "1"){
							SDImageCache.shared().clearMemory()
							SDImageCache.shared().clearDisk(onCompletion: nil)
							self.navigationController?.pushViewController(CompanyHomeViewController(), animated: true)
							print("Admin")
						}
						else if(userRole == "2"){
							SDImageCache.shared().clearMemory()
							SDImageCache.shared().clearDisk(onCompletion: nil)
							self.navigationController?.pushViewController(CompanyHomeViewController(), animated: true)
							print("Admin")
						}
						else if(userRole == "3"){
							SDImageCache.shared().clearMemory()
							SDImageCache.shared().clearDisk(onCompletion: nil)
							self.navigationController?.pushViewController(HomeViewController(), animated: true)
							print("Client")
						}
						
						//self.dismiss(animated: true, completion: nil)
					}
				}
			}
		})
  }
	
	//facebook login button delegate methods
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		if error != nil{
			print(error)
			return
		}
		print("Successfully logged in with facebook...")
		FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start { (connection, result, err) in
			if err != nil{
				print("Failed to start graph request: ", err!)
				return
			}
			print(result!)
		}
	}
	//facebook login button delegate methods ends
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		print("Did Log Out Of Facebook")
	}
	
  func handleRegisterButton() {
    present(RegisterViewController(), animated: true, completion: nil)
  }
  
  func handleFacebookButton() {
		self.activityIndicator.startAnimating()
		FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { (result, error) in
			if error != nil {
				print(error.debugDescription)
				return
			}
			// set looged in status as true
			//UserDefaults.standard.set(true, forKey: LOGGED_IN)
			print("Successfully Logged In")
			self.fetchFBUserInfo()
		})
  }
	func fetchFBUserInfo(){
		FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start { (connection, result, err) in
			if err != nil{
				print("Failed to start graph request: ", err!)
				return
			}
			self.handleSuccessfulLogin()
		}
	}
	
	func handleSuccessfulLogin() {
		if FBSDKAccessToken.current() != nil {
			FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) in
				if error != nil {
					print(error.debugDescription)
					return
				}
				// execute on success
				if let userData = result as? [String: AnyObject] {
					let userName = userData["name"] as! String
					let userEmail = userData["email"] as! String
					
					self.registerSocialMediaUser(userName: userName, userEmail: userEmail)
					// push home view controller scene
				}
			})
		}
	}
	
	func registerSocialMediaUser(userName: String!, userEmail: String!){
		UserDefaults.standard.set(true, forKey: LOGGED_IN)
		print(userName!)
		print(userEmail!)
		self.activityIndicator.startAnimating()
		let params = ["authenticate": "false",
		              "full_name"         : userName!,
		              "user_email"        : userEmail!,
		              "user_role"         : "3"] as [String: Any]
		guard let url = URL(string: "\(API_URL)register_social_user") else { return }
		Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
			response in
			guard response.result.isSuccess else {
				print(response)
				self.activityIndicator.stopAnimating()
				return
			}
			print(response)
			if let responseData = response.data {
				
				let json = JSON(data: responseData)
				if let dictArray = json.array {
					if dictArray[0]["login_status"] == "failed" {
						self.activityIndicator.stopAnimating()
						self.showInvalidCredentialsAlert()
						print("Login failed. Please insert correct email and password")
					}
					else {
						print("login successfull")
						UserDefaults.standard.set(dictArray[0]["auth_token"].string, forKey: USER_AUTH_TOKEN)
						UserDefaults.standard.set(dictArray[0]["user_id"].string, forKey: USER_ID)
						UserDefaults.standard.set(dictArray[0]["firstname"].string, forKey: FIRST_NAME)
						UserDefaults.standard.set(dictArray[0]["lastname"].string, forKey: LAST_NAME)
						UserDefaults.standard.set(dictArray[0]["user_role"].string, forKey: USER_ROLE)
						UserDefaults.standard.set(userEmail, forKey: LOGGED_IN_USER_MAIL)
						self.activityIndicator.stopAnimating()
						self.navigationController?.pushViewController(HomeViewController(), animated: true)
					}
				}
				else{
					print("4")
				}
			}
			else{
				print("Response Data Errror")
			}
		})
	}
  func handleGoogleButton() {
		self.activityIndicator.startAnimating()
		GIDSignIn.sharedInstance().signIn()
  }
  
  func handleForgotPasswordButton() {
		guard let url = URL(string: "http://www.nexoparts.com/contacto.php") else {
			return
		}
		if UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}
