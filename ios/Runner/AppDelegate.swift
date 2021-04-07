import UIKit
import Flutter
import GoogleMaps
import SafariServices
import Firebase
import TwitterKit

@available(iOS 9.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,OPPCheckoutProviderDelegate,SFSafariViewControllerDelegate,PKPaymentAuthorizationViewControllerDelegate {
    
    
    var developmentMode:String = "";
    var checkoutid:String = "";
    var brand:String = "";
    var language:String = "";

    
    var safariVC: SFSafariViewController?
    var transaction: OPPTransaction?
    var provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    var checkoutProvider: OPPCheckoutProvider?
    var Presult:FlutterResult?
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        //        ================= Payment =================
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let paymentChannel = FlutterMethodChannel(name: "com.sokia.app",
                                                  binaryMessenger: controller.binaryMessenger)
        
        paymentChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            self!.Presult = result
            
            // Note: this method is invoked on the UI thread.
            if call.method == "getPaymentMethod"{
                let args = call.arguments as? Dictionary<String,Any>
                self!.brand = (args!["brand"] as? String)!
                self!.developmentMode = (args!["developmentMode"] as? String)!
                self!.checkoutid = (args!["checkoutId"] as? String)!
                self!.language = (args!["language"] as? String)!
                DispatchQueue.main.async {
                    self!.openCheckoutUI(checkoutId: self!.checkoutid, result1: result)
                }
            } else {
                result(FlutterError(code: "1", message: "Method name is not found", details: ""))
            }
        })
        
        //        ================== End Payment ==============
        
        GMSServices.provideAPIKey("AIzaSyAlD-AjHc-bdnyomHFsHtlkXy8gO_neVgg")
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func openCheckoutUI(checkoutId: String,result1: @escaping FlutterResult) {
        
        DispatchQueue.main.async{
            
            let checkoutSettings = OPPCheckoutSettings()
            
            if self.brand == "MADA" {
                checkoutSettings.paymentBrands = ["MADA"]
            }else if self.brand == "APPLEPAY" {
                let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.applepaymosab", countryCode: "SA")
                if #available(iOS 12.1.1, *) {
                    paymentRequest.supportedNetworks = [ PKPaymentNetwork.mada,PKPaymentNetwork.visa,
                                                         PKPaymentNetwork.masterCard ]
                } else {
                    // Fallback on earlier versions
                    paymentRequest.supportedNetworks = [ PKPaymentNetwork.visa,
                                                         PKPaymentNetwork.masterCard ]
                }
                checkoutSettings.applePayPaymentRequest = paymentRequest
                checkoutSettings.paymentBrands = ["APPLEPAY"]
            }else{
                checkoutSettings.paymentBrands = ["VISA", "MASTER","STC_PAY","SADAD","PAYPAL"]
            }
        
            checkoutSettings.displayTotalAmount = true
            if self.language == "ar" {
                checkoutSettings.language = "ar"
            }else{
                checkoutSettings.language = "en"
            }
            
            // Set available payment brands for your shop
            checkoutSettings.shopperResultURL = "com.sokia.app//result"
            
            /*   if #available(iOS 11.0, *) {
             paymentRequest.requiredShippingContactFields = Set([PKContactField.postalAddress])
             } else {
             paymentRequest.requiredShippingAddressFields = .postalAddress
             } */
            
            if self.developmentMode == "LIVE" {
                self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
            }
            
            self.checkoutProvider = OPPCheckoutProvider(paymentProvider: self.provider, checkoutID: checkoutId, settings: checkoutSettings)!
            
            self.checkoutProvider?.delegate = self
            
            self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                guard let transaction = transaction else {
                    // Handle invalid transaction, check error
                    print(error.debugDescription)

                    result1("false invalid transaction")
                    return
                }
                
                self.transaction = transaction
                
                if transaction.type == .synchronous {
                    // If a transaction is synchronous, just request the payment status
                    // You can use transaction.resourcePath or just checkout ID to do it
                    DispatchQueue.main.async {
                        result1("true")
                    }
                } else if transaction.type == .asynchronous {
                    NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                } else {
                    // Executed in case of failure of the transaction for any reason
                    print(self.transaction.debugDescription)
                                    result1("false")
                }
            }, cancelHandler: {
                // Executed if the shopper closes the payment page prematurely
                print(self.transaction.debugDescription)
                result1("cancelled")

            })
        }
    }
    
    @objc func didReceiveAsynchronousPaymentCallback(result: @escaping FlutterResult) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                result("true")
            }
        }
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        print("urlscheme:" + (url.scheme)!)
        
        //        payment
        if url.scheme?.caseInsensitiveCompare("com.sokia.app") == .orderedSame {
            print("Payment is back")
            didReceiveAsynchronousPaymentCallback(result: self.Presult!)
            return true
        }
    
        //        twitter
        else if url.scheme?.localizedCaseInsensitiveCompare("twitterkit-ziSFdNJZge9owWzweU5QeoVkY") == .orderedSame{
            print("Twitter is back")
            TWTRTwitter.sharedInstance().application(app, open: url, options: options)
            return true
        }else{
            return true
        }
    }
    

    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        if let params = try? OPPApplePayPaymentParams(checkoutID: self.checkoutid, tokenData: payment.token.paymentData) as OPPApplePayPaymentParams? {
            
            self.transaction  = OPPTransaction(paymentParams: params)
            
            self.provider.submitTransaction(OPPTransaction(paymentParams: params), completionHandler: { (transaction, error) in
                if (error != nil) {
                    // See code attribute (OPPErrorCode) and NSLocalizedDescription to identify the reason of failure.
                    
                    print(error?.localizedDescription as Any)
                    
                    self.Presult!("false Apple Pay Failed")
                } else {
                    // Send request to your server to obtain transaction status.
                    
                    completion(.success)
                    self.Presult!("true")
                    
                }
            })
        }
    }
}
