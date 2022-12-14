//
//  PlayerViewController.swift
//  Euphoria
//
//  Created by macbook on 29.11.2022.
//

import UIKit
import AVKit

class PlayerViewController: UIViewController, GradientBackground {
    
    @IBOutlet weak var songPoster: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    
    private var player = AVAudioPlayer()
    private var timer: Timer?
    private var playingIndex = 0
    
    public var startingIndex: Int?
    
    var tracks: [Track]?

    override func viewDidLoad() {
        super.viewDidLoad()
        decorate()
    }
    
    private func decorate() {
        playPauseBtn.layer.shadowColor = UIColor.black.cgColor
        playPauseBtn.layer.shadowOffset = CGSize(width: 10, height: 10)
        playPauseBtn.layer.shadowRadius = 35
        playPauseBtn.layer.shadowOpacity = 0.25
        songPoster.layer.shadowColor = UIColor.black.cgColor
        songPoster.layer.shadowOffset = CGSize(width: 10, height: 10)
        songPoster.layer.shadowRadius = 10
        songPoster.layer.shadowOpacity = 1
        nextBtn.layer.shadowColor = UIColor.black.cgColor
        nextBtn.layer.shadowOffset = CGSize(width: 10, height: 10)
        nextBtn.layer.shadowRadius = 35
        nextBtn.layer.shadowOpacity = 0.25
        previousBtn.layer.shadowColor = UIColor.black.cgColor
        previousBtn.layer.shadowOffset = CGSize(width: 10, height: 10)
        previousBtn.layer.shadowRadius = 35
        previousBtn.layer.shadowOpacity = 0.25
        
        self.setGradientBackground(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // about player
        setRounded(image: songPoster)
        if let tracks = tracks {
            playingIndex = startingIndex ?? 0
            setupPlayer(with: tracks[playingIndex])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    // MARK: - Setup the Player
    
    // method that setting up the player with url
    private func setupPlayer(with song: Track) {
        guard let url = song.preview_url
        else {
            dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: NSLocalizedString("Oops", comment: ""), message: NSLocalizedString("Track doesn't have a URL.", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        songTitle.text = song.name
        artistName.text = song.artists.first?.name
        songPoster.sd_setImage(with: URL(string: song.album?.images.first?.url ?? ""), completed: nil)
        
        let url_ = NSURL(string: url)
        downloadFileFromURL(url: url_!)
        
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player.delegate = self
//            player.prepareToPlay()
//
//            // if phone is not in silence then it will be play
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch let error {
//            print(error.localizedDescription)
//        }
        emailNotify(song: song.name)
    }
    
    func downloadFileFromURL(url: NSURL){
        
        let group = DispatchGroup()
        group.enter()

        var downloadTask: URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(
            with: url as URL, completionHandler: { [weak self](URL, response, error) -> Void in
                defer {
                    group.leave()
                }
                self?.start(url: URL! as NSURL)
        })
        downloadTask.resume()
        
        group.notify(queue: .main) { [weak self] in
            if self?.timer == nil {
                self?.timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self!, selector: #selector(self?.updateProgressBar), userInfo: nil, repeats: true)
            }
            self?.play()
        }
    }
    
    public func emailNotify(song: String) {
        let Url = String(format: "http://localhost:8035/notification/email")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                "recipient": "nikus0108@gmail.com",
                "subject":  "Letter from Spotify",
                "content": "\(song)"
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
    }
    
    func start(url:NSURL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.delegate = self
            player.volume = 0.5
            player.prepareToPlay()
            
            // if phone is not in silence then it will be play
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print(NSLocalizedString("AVAudioPlayer init failed", comment: ""))
        }
    }
    
    // MARK: - Player Actions
    
    @objc func updateProgressBar() {
        slider.value = Float(player.currentTime)
        
        elapsedTime.text = getFormattedTime(timeInterval: player.currentTime)
        
        let remTime = player.duration - player.currentTime
        remainingTime.text = getFormattedTime(timeInterval: remTime)
    }
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secsString = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        
        return "\(minsString):\(secsString)"
    }
    
    // helper functions that we call from outside
    func play() {
        slider.value = 0.0
        slider.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
    }
    
    private func setPlayPauseIcon(isPlaying: Bool) {
        playPauseBtn.setImage(UIImage(named: isPlaying ? "play" : "pause"), for: .normal)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        playingIndex += 1
        
        if let tracks = tracks {
            if playingIndex >= tracks.count {
                playingIndex = 0
            }
            setupPlayer(with: tracks[playingIndex])
            play()
            setPlayPauseIcon(isPlaying: player.isPlaying)
        }
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        playingIndex -= 1
        
        if let tracks = tracks {
            if playingIndex < 0 {
                playingIndex = tracks.count - 1
            }
            setupPlayer(with: tracks[playingIndex])
            play()
            setPlayPauseIcon(isPlaying: player.isPlaying)
        }
    }
    
    @IBAction func progressBar(_ sender: UISlider) {
        player.currentTime = Float64(sender.value)
    }
    
    @IBAction func back(_ sender: UIButton) {
        if let parentVC = self.parent as? TabBarViewController {
            parentVC.selectedIndex = 2
        }
    }
}

// MARK: - Extensions

extension PlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        nextPressed(nextBtn)
    }
}



