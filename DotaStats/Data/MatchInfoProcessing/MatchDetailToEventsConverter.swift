import Foundation

final class MatchDetailToEventsConverter {
    typealias ConvertedEventsDictionary = [Int: [MatchEvent]]

    static func convert(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var convertedEventsDictionary: ConvertedEventsDictionary = [:]

        convertedEventsDictionary = convertedEventsDictionary.merging(convertMatchObjectivesDetails(details)) { current, new in
            current + new
        }

        convertedEventsDictionary = convertedEventsDictionary.merging(convertMatchTeamFightsDetails(details)) { current, new in
            current + new
        }

        convertedEventsDictionary = convertedEventsDictionary.merging(convertMatchWardsDetails(details)) { current, new in
            current + new
        }

        return convertedEventsDictionary
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

            let createdEvent = MatchEvent(
                eventType: MatchEventType(rawValue: objectType),
                involvedPlayers: involvedPlayers,
                coordinates: nil)

            if dictionaryToReturn[objectTime] != nil {
                dictionaryToReturn[objectTime]?.append(createdEvent)
            } else {
                dictionaryToReturn[objectTime] = [createdEvent]
            }
        }

        return dictionaryToReturn
    }

    private static func convertMatchTeamFightsDetails(_ details: MatchDetail) -> ConvertedEventsDictionary {
        var dictionaryToReturn: ConvertedEventsDictionary = [:]

        details.teamFights?.forEach { teamFight in
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
                if dictionaryToReturn[timeStamp] != nil {
                    dictionaryToReturn[timeStamp]?.append(createdEvent)
                } else {
                    dictionaryToReturn[timeStamp] = [createdEvent]
                }
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
                      let obsYCoordinate = observer.element.y,
                      let obsStartTime = observer.element.time,
                      let obsEndTime = observer.offset < obsLeftLog.count ?
                      obsLeftLog[observer.offset].time : details.duration
                else {
                    return
                }

                let createdEvent = MatchEvent(
                    eventType: MatchEventType.observer,
                    involvedPlayers: [player],
                    coordinates: (x: obsXCoordinate, y: obsYCoordinate))

                for timeStamp in obsStartTime...obsEndTime {
                    if dictionaryToReturn[timeStamp] != nil {
                        dictionaryToReturn[timeStamp]?.append(createdEvent)
                    } else {
                        dictionaryToReturn[timeStamp] = [createdEvent]
                    }
                }
            }

            for sentry in senLog.enumerated() {
                guard let senXCoordinate = sentry.element.x,
                      let senYCoordinate = sentry.element.y,
                      let senStartTime = sentry.element.time,
                      let senEndTime = sentry.offset < senLeftLog.count ?
                        senLeftLog[sentry.offset].time : details.duration
                else {
                    return
                }

                let createdEvent = MatchEvent(
                    eventType: MatchEventType.sentry,
                    involvedPlayers: [player],
                    coordinates: (x: senXCoordinate, y: senYCoordinate))

                for timeStamp in senStartTime...senEndTime {
                    if dictionaryToReturn[timeStamp] != nil {
                        dictionaryToReturn[timeStamp]?.append(createdEvent)
                    } else {
                        dictionaryToReturn[timeStamp] = [createdEvent]
                    }
                }
            }
        }

        return dictionaryToReturn
    }
}
