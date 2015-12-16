//
//  ViewController.swift
//  MediaPlayground
//
//  Created by csit267-8 on 11/29/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var toggleFullScreen: UISwitch!
    @IBOutlet var movieRegion: UIView!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var toggleCamera: UISwitch!
    @IBOutlet var displayImageView: UIImageView!
    @IBOutlet var playMusicButton: UIButton!
    @IBOutlet var displayNowPlaying: UILabel!
    
    var moviePlayer: MPMoviePlayerController!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var musicPlayer: MPMusicPlayerController!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let movieFile: String = NSBundle.mainBundle().pathForResource("movie", ofType: "m4v")!
        moviePlayer = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: movieFile))
        moviePlayer.allowsAirPlay = true
        moviePlayer.view.frame=self.movieRegion.frame
    }
    
    @IBAction func chooseMusic(sender: AnyObject) {
        musicPlayer.stop()
        displayNowPlaying.text = "No Song Playing"
        playMusicButton.setTitle("Play Music", forState: UIControlState.Normal)
        
        let musicPicker: MPMediaPickerController =
        MPMediaPickerController(mediaTypes: MPMediaType.Music)
        musicPicker.prompt = "Choose Songs to Play"
        musicPicker.allowsPickingMultipleItems = true
        musicPicker.delegate = self
        
        musicPicker.modalPresentationStyle = UIModalPresentationStyle.Popover
        if (musicPicker.popoverPresentationController != nil) {
            musicPicker.popoverPresentationController!.sourceView =
                sender as! UIButton
            musicPicker.popoverPresentationController!.sourceRect =
                (sender as! UIButton).bounds
        }
        
        presentViewController(musicPicker, animated: true, completion: nil)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        musicPlayer.setQueueWithItemCollection(mediaItemCollection)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func playMovie(sender: AnyObject) {
        view.addSubview(moviePlayer.view)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playMovieFinished:", name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
        
        if toggleFullScreen.on
        {
            moviePlayer.setFullscreen(true, animated: true)
        }
        
        moviePlayer.play()
    }
    
    func playMovieFinished(notification: NSNotification)
    {
        NSNotificationCenter.default Center().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
        moviePlayer.view.removeFromSuperview()
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        if recordButton.titleLabel!.text == "Record Audio"
        {
            audioRecorder.record()
            recordButton.setTitle("Stop Recording", forState: UIControlState.Normal)
        }
        else
        {
            audioRecorder.stop()
            recordButton.setTitle("Record Audio", forState: UIControlState.Normal)
        }
        
        // Load the new sound in the audioPlayer for playback
        let soundFileUrl: NSURL = NSURL.fileURLWithPath(NSTemporaryDirectory()+"sound.caf")
        
        do
        {
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundFileUrl)
        }
        catch
        {
        }
    }
    
    @IBAction func PlayAudio(sender: AnyObject) {
        audioPlayer.play()
    }
    
    @IBAction func PlayMusic(sender: AnyObject) {
        if playMusicButton.titleLabel!.text == "Play Music" {
            musicPlayer.play()
            playMusicButton.setTitle("Pause Music", forState: UIControlState.Normal)
            
            let currentSong: MPMediaItem = musicPlayer.nowPlayingItem!
            displayNowPlaying.text = currentSong.valueForProperty(MPMediaItemPropertyTitle)as! String!
        } else {
            musicPlayer.pause()
            playMusicButton.setTitle("Play Music", forState: UIControlState.Normal)
            displayNowPlaying.text = "No Song Playing"
        }
    }
    
    @IBAction func chooseFilter(sender: AnyObject) {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        
        if toggleCamera.on {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.Popover
        if (imagePicker.popoverPresentationController != nil) {
            imagePicker.popoverPresentationController!.sourceView =
                sender as! UIButton
            imagePicker.popoverPresentationController!.sourceRect =
                (sender as! UIButton).bounds
        }
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        displayImageView.image = info[UIImagePickerControllerEditedImage] as! UIImage!

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func applyFilter(sender: AnyObject) {
        let imageToFilter: CIImage = CIImage(image: self.displayImageView.image!)!
        
        let activeFilter: CIFilter = CIFilter(name: "CISepiaTone")!
        activeFilter.setDefaults()
        activeFilter.setValue(0.75, forKey: "inputIntensity")
        activeFilter.setValue(imageToFilter, forKey: "inputImage")
        
        let filteredImage: CIImage = activeFilter.valueForKey("outputImage") as! CIImage
        
        let myNewImage: UIImage = UIImage(CIImage: filteredImage)
        displayImageView.image = myNewImage
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch
        {
            // error handling
        }
        
        //setup the recorder
        let soundFileUrl: NSURL = NSURL.fileURLWithPath(NSTemporaryDirectory()+"sound.caf")

        let soundSetting: [String: AnyObject] =
        [
            AVSampleRateKey:44100.0 as NSNumber,
            AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey:2 as NSNumber,
            AVEncoderAudioQualityKey:AVAudioQuality.High.rawValue as NSNumber
        ]
    
        do
        {
            try audioRecorder = AVAudioRecorder(URL: soundFileUrl, settings: soundSetting)
        } catch
        {
            
        }
        
        //set up audio recorder
        let noSoundFileURL: NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("norecording", ofType: "wav")!)
        
        do
        {
            try audioPlayer = AVAudioPlayer(contentsOfURL: noSoundFileURL)
        }
        catch
        {
        }
        
        //Setup the music player
        musicPlayer = MPMusicPlayerController.systemMusicPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

