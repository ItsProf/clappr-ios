import XCTest
import Quick
import Nimble

class PlaybackTests: QuickSpec {
    override func spec() {
        var dashboardInteractor: DashboardViewInteractor!
        var playerInteractor: PlayerViewInteractor!
        var app: XCUIApplication!

        var window: XCUIElement {
            return app.windows.element(boundBy: 0)
        }

        describe(".AVFoundationPlayback") {
            beforeEach {
                app = XCUIApplication()
                app.launch()
                XCUIDevice.shared.orientation = .portrait

                dashboardInteractor = DashboardViewInteractor(app: app)
                playerInteractor = PlayerViewInteractor(app: app)
            }

            afterEach {
                app.terminate()
            }

            context("when video is playing") {
                it("is in playing state") {
                    dashboardInteractor.startVideo()
                    playerInteractor.tapOnContainer()

                    expect(app.isVideoIn(state: .buffering)).to(beTrue())
                    expect(app.isVideoIn(state: .playing)).to(beTrue())
                }
            }

            context("when video is buffering") {
                it("is buffering state") {
                    dashboardInteractor.startVideo()
                    playerInteractor.tapOnContainer()

                    expect(app.isVideoIn(state: .buffering)).to(beTrue())
                }
            }
        }
    }
}
