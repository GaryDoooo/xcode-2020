//
//  ViewController.swift
//  midi notes
//
//  Created by Eric Maddy on 1/8/20.
//  Copyright © 2020 Eric Maddy. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
//    var midiplayer1: AVMIDIPlayer?
//    var midiplayer2: AVMIDIPlayer?
//    var midiplayer3: AVMIDIPlayer?
    var players: [AVMIDIPlayer] = []
    let notes: [String] = ["c3s", "d3s", "e3s", "f3s", "g3s"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var player: AVMIDIPlayer?
        for note in notes {
            for _ in 1 ... 3 {
                player = init_midiplayer(note: note)
                players.append(player!)
//        midiplayer2 = init_midiplayer(note: "d3s")
            }
        }
//        init_midiplayer(player: midiplayer3!)
    }

    @IBAction func c3down(_ sender: Any) {
//        var player: AVMIDIPlayer?
//        if !midiplayer1!.isPlaying || midiplayer1!.currentPosition > 0.1 {
//        if midiplayer1!.isPlaying {
        ////        midiplayer1?.stop()
//            //            usleep(50000)
//            midiplayer1?.currentPosition = 0
//        } else {
//            midiplayer1?.play({})
//        }
//        player = init_midiplayer(note: "c3s")
//        player?.delegate = self
//        player?.numberOfLoops = 0
//        player!.play()
//        self.players.append(player!)
//        var i:Int8
        play_note(offset: 0)
    }

    @IBAction func d3down(_ sender: Any) {
//        if !midiplayer2!.isPlaying || midiplayer2!.currentPosition > 0.1 {
//            midiplayer2?.stop()
//            //            usleep(50000)
//            midiplayer2?.currentPosition = 0
//            midiplayer2?.play({})
//        }
        play_note(offset: 3)
    }

    @IBAction func e3down(_ sender: Any) {
        play_note(offset: 6)
    }

    @IBAction func f3down(_ sender: Any) {
        play_note(offset: 9)
    }

    @IBAction func g3down(_ sender: Any) {
        play_note(offset: 12)
    }

    func play_note(offset: Int) {
        for i in offset ... offset + 2 {
            if !players[i].isPlaying || players[i].currentPosition > 0.3 {
                players[i].stop()
                players[i].currentPosition = 0
                players[i].play({})
                print("play ", i)
                break
            }
        }
    }
}

func init_midiplayer(note: String) -> AVMIDIPlayer {
    var player: AVMIDIPlayer?
    guard let midiFileURL = Bundle.main.url(forResource: note, withExtension: "mid") else {
        fatalError("\"ntbldmtn.mid\" file not found.")
    }
    guard let bankURL = Bundle.main.url(forResource: "GeneralUser GS MuseScore v1.442", withExtension: "sf2") else {
        fatalError("\"sound font 2\" file not found.")
    }
    do {
        try player = AVMIDIPlayer(contentsOf: midiFileURL, soundBankURL: bankURL)
        print("created midi player with sound bank url \(bankURL)")
    } catch let error as NSError {
        print("Error \(error.localizedDescription)")
    }

    player?.prepareToPlay()
//    player?.play()
    return player!
}
