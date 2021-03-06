import AVFoundation

open class Playback: UIBaseObject, Plugin {
    open class var type: PluginType { return .playback }

    @objc open class var name: String {
        return self.init().pluginName
    }

    @objc open var pluginName: String {
        NSException(name: NSExceptionName(rawValue: "MissingPluginName"), reason: "Playback Plugins should always declare a name", userInfo: nil).raise()
        return ""
    }

    open var selectedSubtitle: MediaOption?
    open var selectedAudioSource: MediaOption?
    fileprivate(set) open var subtitles: [MediaOption]?
    fileprivate(set) open var audioSources: [MediaOption]?

    @objc internal(set) open var options: Options

    @objc open var source: String? {
        return options[kSourceUrl] as? String
    }

    @objc open var startAt: TimeInterval {
        return options[kStartAt] as? TimeInterval ?? 0.0
    }

    @objc open var isPlaying: Bool {
        return false
    }

    @objc open var isPaused: Bool {
        return false
    }

    @objc open var isBuffering: Bool {
        return false
    }

    @objc open var duration: Double {
        return 0.0
    }

    @objc open var position: Double {
        return 0.0
    }

    @objc open var settings: [String: Any] {
        return [:]
    }

    open var playbackType: PlaybackType {
        return .unknown
    }

    @objc open var isHighDefinitionInUse: Bool {
        return false
    }

    public required init() {
        options = [:]
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
    }

    @objc public required init(options: Options) {
        Logger.logDebug("loading with \(options)", scope: "\(Swift.type(of: self))")
        self.options = options
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = false
    }

    public required init?(coder _: NSCoder) {
        fatalError("Use init(url: NSURL) instead")
    }

    @objc public required init(context _: UIBaseObject) {
        fatalError("Use init(url: NSURL) instead")
    }

    @objc open class func canPlay(_: Options) -> Bool {
        return false
    }

    open override func render() {
        once(Event.ready.eventName()) { [unowned self] _ in
            if self.startAt != 0.0 {
                self.seek(self.startAt)
            }

            self.selectDefaultMediaOptions()
        }
    }

    fileprivate func selectDefaultMediaOptions() {
        if let defaultSubtitleLanguage = options[kDefaultSubtitle] as? String,
            let defaultSubtitle = subtitles?.filter({ $0.language == defaultSubtitleLanguage }).first {
            selectedSubtitle = defaultSubtitle
        }

        if let defaultAudioLanguage = options[kDefaultAudioSource] as? String,
            let defaultAudioSource = audioSources?.filter({ $0.language == defaultAudioLanguage }).first {
            selectedAudioSource = defaultAudioSource
        }
    }

    @objc open func play() {}
    @objc open func pause() {}
    @objc open func stop() {}
    @objc open func seek(_: TimeInterval) {}

    @objc open func destroy() {
        Logger.logDebug("destroying", scope: "Playback")
        Logger.logDebug("destroying ui elements", scope: "Playback")
        removeFromSuperview()
        Logger.logDebug("destroying listeners", scope: "Playback")
        stopListening()
        Logger.logDebug("destroyed", scope: "Playback")
    }
}
