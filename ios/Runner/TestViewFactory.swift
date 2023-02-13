//
//  TestViewFactory.swift
//  Runner
//
//  Created by xiang.wang on 2022/10/17.
//
import Flutter
import UIKit
import TrustlyIosSdk
import WebKit

class TestView:NSObject,FlutterPlatformView,TrustlyCheckoutDelegate{
    func onTrustlyCheckoutRequstToOpenURLScheme(urlScheme: String) {
        
    }
    
    func onTrustlyCheckoutSuccessfull(urlString: String?) {
    
    }
    
    func onTrustlyCheckoutAbort(urlString: String?) {
    
    }
    
    func onTrustlyCheckoutError() {
    
    }
    
    private var _view: UIView
    
    
    func view() -> UIView {
        return _view
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?) {
        self._view = UIView()

        super.init()
        createNativeView(view:self._view,arguments: args)
            
            let channel:FlutterBasicMessageChannel=FlutterBasicMessageChannel(name: "aa", binaryMessenger:messenger!)
            channel.sendMessage("a message from iOS")
    }
    
    func createNativeView(view _view: UIView,arguments args: Any?){
        let trustyView = TrustlyWKWebView(
            checkoutUrl: "https://checkout.test.trustly.com/checkout?OrderID=13595627702&SessionID=03ea7ae8-7df6-44e3-ba51-35ee72d67cb5",
            frame:UIScreen.main.bounds
        )
        
        trustyView?.delegate = self

        _view.addSubview(trustyView!)
    }
}

class TestViewFactory:NSObject,FlutterPlatformViewFactory{
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
            self.messenger = messenger
            super.init()
        }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return TestView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class TestViewPlugin:NSObject,FlutterPlugin{
    static func register(with registrar: FlutterPluginRegistrar) {
        let factory = TestViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "iOS.testView")
    }
}
