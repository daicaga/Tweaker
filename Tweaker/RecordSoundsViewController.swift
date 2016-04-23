//
//  ViewController.swift
//  Tweaker
//
//  Created by Harshit Bhat on 23/04/16.
//  Copyright © 2016 Harshit Bhat. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        recordingLabel.text = "Recording in progress"
        recordingButton.enabled = false
        stopRecordingButton.enabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true )[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.text = "Tap to record"
        stopRecordingButton.enabled = false
        recordingButton.enabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        print("AV Audio Recorder finished recording" )
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)

        }
        else {
            print("Saving of recording failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudio = recordedAudioURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

