//
//  AudioPlayerService.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 10/09/23.
//

import Foundation
import AVKit

protocol AudioPlayerService {
  func playAudio()
}


final class DefaultAudioPlayer: AudioPlayerService {
  private var player: AVAudioPlayer?
  final func playAudio() {
    let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
    let url = URL(fileURLWithPath: path)
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch(let error) {
      print(error.localizedDescription)
    }
  }
}
