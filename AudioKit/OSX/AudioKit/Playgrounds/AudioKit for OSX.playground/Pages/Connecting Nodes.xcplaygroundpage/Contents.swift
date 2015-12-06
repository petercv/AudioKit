//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Connecting Nodes
//: ### Playing audio is great, but now let's process that audio. This page demonstrates how nodes can be connected together to process an input source.
import XCPlayground
import AudioKit

//: Change the source to "mic" to process your voice
let source = "player"

//: This section prepares the player and the microphone
let audiokit = AKManager.sharedInstance
let mic = AKMicrophone()
let bundle = NSBundle.mainBundle()
let file = bundle.pathForResource("808loop", ofType: "wav")
let player = AKAudioPlayer(file!)
player.looping = true
let playerWindow: AKAudioPlayerWindow

//: Next, we'll connect the audio source to a delay
let delay: AKDelay
switch source {
case "mic":
    delay = AKDelay(mic)
default:
    delay = AKDelay(player)
    playerWindow = AKAudioPlayerWindow(player)
}

delay.//: Set the parameters of the delay here
time = 0.1 // seconds
delay.feedback  = 80 // Percent
delay.dryWetMix = 60 // Percent

var delayWindow  = AKDelayWindow(delay)

//: You can continue add more nodes as you wish, and here we add a reverb
let reverb = AKReverb(delay)
reverb.loadFactoryPreset(.Cathedral)

audiokit.audioOutput = reverb
audiokit.start()

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)