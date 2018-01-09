//
//  ViewController.swift
//  Waifu
//
//  Created by Raining on 2018-01-07.
//  Copyright © 2018 RainingZ. All rights reserved.
//

import UIKit
import Foundation

struct vars {
    static var backgrounds = [String]()
    static var current_background:Int = 1
    static var imageView = UIImageView()
    //static var queue =
}

extension UIImageView {
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.alpha = 0.9
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}

func assignBackground(VC:UIViewController, name:String) {
    let background = UIImage(named: name)
    vars.imageView = UIImageView(frame: VC.view.bounds)
    vars.imageView.contentMode = UIViewContentMode.scaleAspectFill
    vars.imageView.image = background
    vars.imageView.center = VC.view.center
    VC.view.addSubview(vars.imageView)
    //vars.imageView.makeBlurImage(targetImageView: vars.imageView)
    VC.view.sendSubview(toBack: vars.imageView)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        vars.backgrounds = ["iPhone-Black.jpg", "MapleLeafOnGround.jpg", "MapleLeafOnWater.jpg", "iPhone-Maple1.jpg", "iPhone-Maple2.jpg", "iPhone-Maple3.jpg"]
        //vars.backgrounds[1] = "Resources/MapleLeafOnGround.jpg"
        // Do any additional setup after loading the view, typically from a nib.
        assignBackground(VC: self,name: vars.backgrounds[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
