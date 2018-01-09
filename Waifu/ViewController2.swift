//
//  ViewController2.swift
//  Waifu
//
//  Created by Raining on 2018-01-07.
//  Copyright © 2018 RainingZ. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var waifu_view: UIView!
    @IBOutlet weak var waifu_image: UIImageView!
    @IBOutlet weak var home_button: UIButton!
    @IBOutlet weak var ye_image: UIImageView!
    @IBOutlet weak var no_image: UIImageView!
    @IBAction func pan_gest(_ sender: UIPanGestureRecognizer) {
        let screen = sender.view!
        let point = sender.translation(in: view)
        screen.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y/5)
        let offset_x = screen.center.x - view.center.x
        if (offset_x < 0) {
            ye_image.alpha = 0
            no_image.alpha = abs(offset_x) / view.center.x
        }
        else {
            no_image.alpha = 0
            ye_image.alpha = abs(offset_x) / view.center.x
        }
        
        screen.alpha = 1 - abs(offset_x) / view.center.x
        
        screen.transform = CGAffineTransform(rotationAngle: offset_x / (view.frame.width/2/0.30))
        
        if (sender.state == UIGestureRecognizerState.ended) {
            
            // Swipe to left
            if (screen.center.x < 60) {
                UIView.animate(withDuration: 0.3, animations: {
                    screen.center = CGPoint(x: screen.center.x - 200, y: screen.center.y)
                    screen.alpha = 0
                    self.no_image.alpha = 1
                })
                
                // Heartbeat effect
                UIView.animate(withDuration: 0.1, animations: {
                    self.no_image.frame = CGRect(x: self.no_image.frame.origin.x-20, y: self.no_image.frame.origin.y-20, width: 140, height: 140)
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.no_image.frame = CGRect(x: self.no_image.frame.origin.x+20, y: self.no_image.frame.origin.y+20, width: 100, height: 100)
                    })
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    screen.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
                    screen.transform = CGAffineTransform.identity
                    
                    self.next_waifu()
                })
            }
                
                // Swipe to right
            else if (screen.center.x > view.frame.width - 60) {
                UIView.animate(withDuration: 0.3, animations: {
                    screen.center = CGPoint(x: screen.center.x + 200, y: screen.center.y)
                    screen.alpha = 0
                    self.ye_image.alpha = 1
                })
                
                // Heartbeat effect
                UIView.animate(withDuration: 0.1, animations: {
                    self.ye_image.frame = CGRect(x: self.ye_image.frame.origin.x-20, y: self.ye_image.frame.origin.y-20, width: 140, height: 140)
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.ye_image.frame = CGRect(x: self.ye_image.frame.origin.x+20, y: self.ye_image.frame.origin.y+20, width: 100, height: 100)
                    })
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    screen.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
                    screen.transform = CGAffineTransform.identity
                    
                    self.next_waifu()
                })
            }
                
                // Swipe in-between two thresholds
            else {
                UIView.animate(withDuration: 0.5, animations: {
                    screen.center = self.view.center
                    screen.alpha = 1
                    self.ye_image.alpha = 0
                    self.no_image.alpha = 0
                    screen.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    func next_waifu() {
        // use a queue and randomize eventually
        if (vars.current_background < vars.backgrounds.count - 1) {
            vars.current_background = vars.current_background + 1
        }
        else {
            vars.current_background = 1
        }
        print(vars.current_background)
        waifu_image.image = UIImage(named: vars.backgrounds[vars.current_background])
        
        UIView.animate(withDuration: 0.5) {
            self.ye_image.alpha = 0
            self.no_image.alpha = 0
            self.waifu_view.center = self.view.center
            self.waifu_view.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home_button.layer.cornerRadius = 30
        home_button.layer.borderWidth = 0
        waifu_image.image = UIImage(named: vars.backgrounds[vars.current_background])
        ye_image.alpha = 0
        no_image.alpha = 0
        self.view.sendSubview(toBack: waifu_view)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
