//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Zhanel  on 04.11.2025.
//

import UIKit
import AVFoundation

struct TrackItem {
    let title: String
    let cover: UIImage
    let audioFile: String
}

class ViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVAudioPlayer?
    var currentTrackIndex = 3
    var isPlaying = false
    
   
    let tracks: [TrackItem] = [
        TrackItem(title: "Кайрат Нуртас - Аңсайды жаным", cover: UIImage(named: "cover1")!, audioFile: "song1"),
        TrackItem(title: "V $ X V PRiNCE - Вкусный (intro)", cover: UIImage(named: "cover2")!, audioFile: "song2"),
        TrackItem(title: "V $ X V PRiNCE - Welcome", cover: UIImage(named: "cover3")!, audioFile: "song3"),
        TrackItem(title: "NAZZARBECK - JЫN ҰRADЫ", cover: UIImage(named: "cover4")!, audioFile: "song4"),
        TrackItem(title: "IL’HAN - Val's", cover: UIImage(named: "cover5")!, audioFile: "song5"),
        TrackItem(title: "SYenlik · Аль Nasr - 16 Qyz", cover: UIImage(named: "cover6")!, audioFile: "song6"),
        TrackItem(title: "Yenlik - Meili", cover: UIImage(named: "cover7")!, audioFile: "song7"),
        TrackItem(title: "RaiM – Kolikpen", cover: UIImage(named: "cover8")!, audioFile: "song8"),
        TrackItem(title: "RaiM - WHATCHA WANNA ", cover: UIImage(named: "cover9")!, audioFile: "song9"),
        TrackItem(title: "V $ X V PRiNCE X BOLLO - ПУСТО", cover: UIImage(named: "cover10")!, audioFile: "song10")
    ]
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateUI(for: currentTrackIndex)
        }
        
        func updateUI(for index: Int) {
            let track = tracks[index]
            titleLabel.text = track.title
            coverImageView.image = track.cover
        }
        
        func playTrack(at index: Int) {
            let track = tracks[index]
            updateUI(for: index)
            
            guard let url = Bundle.main.url(forResource: track.audioFile, withExtension: "mp3") else {
                print("Audio file not found for \(track.title)")
                return
            }
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                isPlaying = true
            } catch {
                print("Error playing \(track.title): \(error)")
            }
        }
        
        @IBAction func previousTapped(_ sender: UIButton) {
            currentTrackIndex = (currentTrackIndex - 1 + tracks.count) % tracks.count
            updateUI(for: currentTrackIndex)
            player = nil
            if isPlaying {
                playTrack(at: currentTrackIndex)
            }
        }
        
        @IBAction func playPauseTapped(_ sender: UIButton) {
            if let player = player {
                if player.isPlaying {
                    player.pause()
                    isPlaying = false
                } else {
                    player.play()
                    isPlaying = true
                }
            } else {
                playTrack(at: currentTrackIndex)
            }
        }
        
        @IBAction func nextTapped(_ sender: UIButton) {
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            updateUI(for: currentTrackIndex)
            player = nil
            if isPlaying {
                playTrack(at: currentTrackIndex)
            }
        }
    }
