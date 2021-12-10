import Foundation

enum SearchPlayerModuleViewState {
    // вопрос: нужен ли пустой стейт для вью? в случае если нет результата по запросу 
    // case empty
    case loading
    case success([Player])
    case failure(SearchPlayerModuleError)
}
