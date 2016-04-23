//
//  PlaySoundViewController.swift
//  Tweaker
//
//  Created by Harshit Bhat on 23/04/16.
//  Copyright © 2016 Harshit Bhat. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var chipMunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverb: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {
        case Slow = 0 , Fast , Chipmunk , Vader , Echo , Reverb }
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play sound Button pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button pressed")
        stopAudio()
    }
    
    
    
    var recordedAudio : NSURL!
    var recordedAudioURL: NSURL!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Play sound view controller loaded")
        print(recordedAudioURL)
        setupAudio()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
