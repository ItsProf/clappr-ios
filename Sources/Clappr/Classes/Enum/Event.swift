@objc public enum Event: NSInteger {
    case bufferUpdate
    case positionUpdate
    case ready
    case stalled
    case willUpdateAudioSource
    case didUpdateAudioSource
    case willUpdateSubtitleSource
    case didUpdateSubtitleSource
    case disableMediaControl
    case enableMediaControl
    case didComplete
    case willPlay
    case playing
    case willPause
    case didPause
    case willStop
    case didStop
    case error
    case airPlayStatusUpdate
    case requestFullscreen
    case exitFullscreen
    case requestPosterUpdate
    case willUpdatePoster
    case didUpdatePoster
    case seek
    case willSeek
    case didSeek
    
    func eventName() -> String {
        switch self {
        case .bufferUpdate:
            return "bufferUpdate"
        case .positionUpdate:
            return "positionUpdate"
        case .ready:
            return "ready"
        case .stalled:
            return "stalled"
        case .willUpdateAudioSource:
            return "willUpdateAudioSource"
        case .didUpdateAudioSource:
            return "didUpdateAudioSource"
        case .willUpdateSubtitleSource:
            return "willUpdateSubtitleSource"
        case .didUpdateSubtitleSource:
            return "didUpdateSubtitleSource"
        case .disableMediaControl:
            return "disableMediaControl"
        case .enableMediaControl:
            return "enableMediaControl"
        case .didComplete:
            return "didComplete"
        case .willPlay:
            return "willPlay"
        case .playing:
            return "playing"
        case .willPause:
            return "willPause"
        case .didPause:
            return "didPause"
        case .willStop:
            return "willStop"
        case .didStop:
            return "didStop"
        case .error:
            return "error"
        case .airPlayStatusUpdate:
            return "airPlayStatusUpdate"
        case .requestFullscreen:
            return "requestFullscreen"
        case .exitFullscreen:
            return "exitFullscreen"
        case .requestPosterUpdate:
            return "requestPosterUpdate"
        case .willUpdatePoster:
            return "willUpdatePoster"
        case .didUpdatePoster:
            return "didUpdatePoster"
        case .seek:
            return "seek"
        case .willSeek:
            return "willSeek"
        case .didSeek:
            return "didSeek"
        }
    }
}
