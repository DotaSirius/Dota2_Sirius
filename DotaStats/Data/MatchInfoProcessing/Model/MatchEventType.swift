import Foundation

enum MatchEventType: String {
    case firstBlood = "CHAT_MESSAGE_FIRSTBLOOD"
    case courierLost = "CHAT_MESSAGE_COURIER_LOST"
    case buildingKill = "building_kill"
    case roshkanKill = "CHAT_MESSAGE_ROSHAN_KILL"
    case aegis = "CHAT_MESSAGE_AEGIS"
    case observer = "observer"
    case sentry = "sentry"
    case teamFight = "teamFight"
}
