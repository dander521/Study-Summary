//
//  MicMonitor.swift
//  RecorderAndSpeakerAnimation
//
//  Created by 倩倩 on 16/4/5.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import Foundation
import AVFoundation

class MicMonitor: NSObject
{
    private var recorder: AVAudioRecorder!
    private var timer: NSTimer?
    private var levelsHandler: ((Float)->Void)?
    
    override init() {
        let url = NSURL(fileURLWithPath: "/dev/null", isDirectory: true)
        let settings: [String: AnyObject] = [
            AVSampleRateKey: 44100.0, // 音乐采样率
            AVNumberOfChannelsKey: 1, // 音乐通道数
            AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatAppleLossless), // 音乐格式
            AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue // 录制质量
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        if audioSession.recordPermission() != .Granted
        {
            audioSession.requestRecordPermission({success in
                print("microphone permission: \(success)")
            })
        }
        
        do {
            try recorder = AVAudioRecorder(URL: url, settings: settings)
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("Couldn't initialize the mic input")
        }
        
        if let recorder = recorder {
            // start observing mic levels
            recorder.prepareToRecord()
            recorder.meteringEnabled = true
        }
    }
    
    func startMonitoringWithHandler(handler: (Float)->Void)
    {
        levelsHandler = handler
        
        // start meters
        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "handleMicLevel:", userInfo: nil, repeats: true)
        recorder.record()
    }
    
    func stopMonitoring()
    {
        levelsHandler = nil
        timer?.invalidate()
        recorder.stop()
    }
    
    func handleMicLevel(timer: NSTimer)
    {
        recorder.updateMeters()
        levelsHandler?(recorder.averagePowerForChannel(0))
    }
    
    deinit
    {
        stopMonitoring()
    }
}
