//
//  ViewController.swift
//  midi1
//
//  Created by Eric Maddy on 1/8/20.
//  Copyright © 2020 Eric Maddy. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var midiplayer: AVMIDIPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let midiFileURL = Bundle.main.url(forResource: "ntbldmtn", withExtension: "mid") else {
            fatalError("\"ntbldmtn.mid\" file not found.")
        }
        guard let bankURL = Bundle.main.url(forResource: "GeneralUser GS MuseScore v1.442", withExtension: "sf2") else {
            fatalError("\"sound font 2\" file not found.")
        }
        do {
            try midiplayer = AVMIDIPlayer(contentsOf: midiFileURL, soundBankURL: bankURL)
            print("created midi player with sound bank url \(bankURL)")
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }

        midiplayer?.prepareToPlay()
    }

    func play_finished() {
        print("play done.")
        midiplayer?.currentPosition = 0
    }

    @IBAction func playnow(_ sender: Any) {
        midiplayer?.play({self.play_finished()})
    }
}
