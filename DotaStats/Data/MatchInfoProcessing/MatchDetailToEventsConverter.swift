import Foundation

class MatchDetailToEventsConverter {
    typealias ConvertedEventsDictionary = [Int: MatchEvent]

    static func convert(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var dictionaryToReturn: ConvertedEventsDictionary = [:]

        dictionaryToReturn = dictionaryToReturn.merging(convertMatchObjectivesDetails(details)) { current, _ in
            current
        }

        dictionaryToReturn = dictionaryToReturn.merging(convertMatchTeamFightsDetails(details)) { current, _ in
            current
        }

        dictionaryToReturn = dictionaryToReturn.merging(convertMatchWardsDetails(details)) { current, _ in
            current
        }

        return dictionaryToReturn
    }

    private static func convertMatchObjectivesDetails(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var dictionaryToReturn: ConvertedEventsDictionary = [:]

        details.objectives?.forEach { object in
            guard let objectTime = object.time,
                  let objectType = object.type,
                  let objectPlayerSlot = object.playerSlot
                    else {
                return
            }

            let involvedPlayer = details.players.first { player in
                player.playerSlot == objectPlayerSlot
            }

            let involvedPlayers = [involvedPlayer].compactMap {
                $0
            }

            dictionaryToReturn[objectTime] = MatchEvent(
                    eventType: MatchEventType(rawValue: objectType),
                    involvedPlayers: involvedPlayers,
                    coordinates: nil)
        }

        return dictionaryToReturn
    }

    private static func convertMatchTeamFightsDetails(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var dictionaryToReturn: ConvertedEventsDictionary = [:]

        details.teamfights?.forEach { teamFight in
            guard let startTime = teamFight.start,
                  let endTime = teamFight.end
                    else {
                return
            }

            let createdEvent = MatchEvent(
                    eventType: MatchEventType.teamFight,
                    involvedPlayers: details.players,
                    coordinates: nil)

            for timeStamp in startTime...endTime {
                dictionaryToReturn[timeStamp] = createdEvent
            }
        }

        return dictionaryToReturn
    }

    private static func convertMatchWardsDetails(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var dictionaryToReturn: ConvertedEventsDictionary = [:]

        details.players.forEach { player in
            guard let obsLog = player.obsLog,
                  let obsLeftLog = player.obsLeftLog,
                  let senLog = player.senLog,
                  let senLeftLog = player.senLeftLog
                    else {
                return
            }

            for observer in obsLog.enumerated() {
                guard let obsXCoordinate = observer.element.x,
                      let obsYCoordinate = observer.element.x,
                      let obsStartTime = observer.element.time,
                      let obsEndTime = obsLeftLog[observer.offset].time
                        else {
                    return
                }

                let createdEvent = MatchEvent(
                        eventType: MatchEventType.observer,
                        involvedPlayers: [player],
                        coordinates: (x: obsXCoordinate, y: obsYCoordinate))

                for timeStamp in obsStartTime...obsEndTime {
                    dictionaryToReturn[timeStamp] = createdEvent
                }
            }

            for sentry in senLog.enumerated() {
                guard let senXCoordinate = sentry.element.x,
                      let senYCoordinate = sentry.element.x,
                      let senStartTime = sentry.element.time,
                      let senEndTime = senLeftLog[sentry.offset].time
                        else {
                    return
                }

                let createdEvent = MatchEvent(
                        eventType: MatchEventType.sentry,
                        involvedPlayers: [player],
                        coordinates: (x: senXCoordinate, y: senYCoordinate))

                for timeStamp in senStartTime...senEndTime {
                    dictionaryToReturn[timeStamp] = createdEvent
                }
            }
        }
        
        return dictionaryToReturn
    }
}
