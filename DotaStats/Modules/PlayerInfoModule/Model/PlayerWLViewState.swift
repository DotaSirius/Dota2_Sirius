import Foundation

struct PlayerWLViewState {
    let win: Int
    let lose: Int

    init(win: Int = 0, lose: Int = 0) {
        self.win = win
        self.lose = lose
    }
}
