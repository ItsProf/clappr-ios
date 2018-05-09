open class SpinnerPlugin: UIContainerPlugin {

    fileprivate var spinningWheel: UIActivityIndicatorView!

    @objc var isAnimating: Bool {
        return spinningWheel.isAnimating
    }

    public required init() {
        super.init()
    }

    open override var pluginName: String {
        return "spinner"
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public required init(context: UIBaseObject) {
        super.init(context: context)
        spinningWheel = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        addSubview(spinningWheel)
        isUserInteractionEnabled = false
        bindDidChangePlayback()
        accessibilityIdentifier = "SpinnerPlugin"
    }

    private func bindDidChangePlayback() {
        if let container = self.container {
            listenTo(container, eventName: InternalEvent.didChangePlayback.rawValue) { [weak self] (info: EventUserInfo) in self?.didChangePlayback(info) }
        }
    }

    private func didChangePlayback(_: EventUserInfo) {
        stopListening()
        bindPlaybackEvents()
        bindDidChangePlayback()
    }

    open override func render() {
        addCenteringConstraints()
    }

    fileprivate func addCenteringConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: spinningWheel.frame.width)
        addConstraint(widthConstraint)

        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: spinningWheel.frame.height)
        addConstraint(heightConstraint)

        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX,
                                                   relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0)
        container?.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY,
                                                   relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0)
        container?.addConstraint(yCenterConstraint)
    }

    private func bindPlaybackEvents() {
        guard let playback = container?.playback else { return }
        listenTo(playback, eventName: Event.playing.eventName()) { [weak self] (info: EventUserInfo) in self?.stopAnimating(info) }
        listenTo(playback, eventName: Event.stalled.eventName()) { [weak self] (info: EventUserInfo) in self?.startAnimating(info) }
        listenTo(playback, eventName: Event.error.eventName()) { [weak self] (info: EventUserInfo) in self?.stopAnimating(info) }
        listenTo(playback, eventName: Event.didComplete.eventName()) { [weak self] (info: EventUserInfo) in self?.stopAnimating(info) }

    }

    fileprivate func startAnimating(_: EventUserInfo) {
        isHidden = false
        spinningWheel.startAnimating()
        Logger.logDebug("started animating spinning wheel", scope: pluginName)
    }

    fileprivate func stopAnimating(_: EventUserInfo) {
        isHidden = true
        spinningWheel.stopAnimating()
        Logger.logDebug("stoped animating spinning wheel", scope: pluginName)
    }

    open override func destroy() {
        super.destroy()
        Logger.logDebug("destroying", scope: "SpinnerPlugin")
        Logger.logDebug("destroying ui elements", scope: "SpinnerPlugin")
        removeFromSuperview()
        Logger.logDebug("destroyed", scope: "SpinnerPlugin")
    }
}
