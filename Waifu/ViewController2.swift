//
//  ViewController2.swift
//  Waifu
//
//  Created by Raining on 2018-01-07.
//  Copyright © 2018 RainingZ. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var ye: UIButton!
    @IBOutlet weak var na: UIButton!
    @IBOutlet weak var waifu_view: UIView!
    @IBOutlet weak var waifu_image: UIImageView!
    
    @IBAction func pan_gest(_ sender: UIPanGestureRecognizer) {
        let screen = sender.view!
        let point = sender.translation(in: view)
        screen.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let offset_x = screen.center.x - view.center.x
        if (offset_x < 0) {
            na.tintColor = UIColor.red
            ye.tintColor = UIColor.white
        }
        else {
            ye.tintColor = UIColor.green
            na.tintColor = UIColor.white
        }
        
        screen.alpha = 1 - abs(offset_x) / view.center.x
        
        
        if (sender.state == UIGestureRecognizerState.ended) {
            
            if (screen.center.x < 60) {
                UIView.animate(withDuration: 0.3, animations: {
                    screen.center = CGPoint(x: screen.center.x - 200, y: screen.center.y)
                    screen.alpha = 0
                })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    screen.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
                    self.next_waifu()
                })
            }
            
            else if (screen.center.x > view.frame.width - 60) {
                UIView.animate(withDuration: 0.3, animations: {
                    screen.center = CGPoint(x: screen.center.x + 200, y: screen.center.y)
                    screen.alpha = 0
                })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    screen.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
                    self.next_waifu()
                })
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                    screen.center = self.view.center
                    screen.alpha = 1
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
            self.waifu_view.center = self.view.center
            self.waifu_view.alpha = 1
        }
    }
    
    @IBAction func na_button_press(_ sender: Any) {
        next_waifu()
    }
    
    @IBAction func ye_button_press(_ sender: Any) {
        next_waifu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waifu_image.image = UIImage(named: vars.backgrounds[vars.current_background])
        self.view.sendSubview(toBack: waifu_view)
        assignBackground(VC: self, name: "iPhone-Black.jpg")
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
