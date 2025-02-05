import Foundation

public enum WikimediaProject: Hashable {
    public typealias LanguageCode = String
    public typealias LocalizedLanguageName = String
    public typealias LanguageVariantCode = String
    case wikipedia(LanguageCode, LocalizedLanguageName, LanguageVariantCode?)
    case wikibooks(LanguageCode, LocalizedLanguageName)
    case wiktionary(LanguageCode, LocalizedLanguageName)
    case wikiquote(LanguageCode, LocalizedLanguageName)
    case wikisource(LanguageCode, LocalizedLanguageName)
    case wikinews(LanguageCode, LocalizedLanguageName)
    case wikiversity(LanguageCode, LocalizedLanguageName)
    case wikivoyage(LanguageCode, LocalizedLanguageName)
    case mediawiki
    case wikispecies
    case commons
    case wikidata
    
    public var projectIconName: String? {
        switch self {
        case .commons:
            return "wikimedia-project-commons"
        case .wikidata:
            return "wikimedia-project-wikidata"
        case .wikiquote:
            return "wikimedia-project-wikiquote"
        case .wikipedia:
            return nil
        case .wikibooks:
            return "wikimedia-project-wikibooks"
        case .wiktionary:
            return "wikimedia-project-wiktionary"
        case .wikisource:
            return "wikimedia-project-wikisource"
        case .wikinews:
            return "wikimedia-project-wikinews"
        case .wikiversity:
            return "wikimedia-project-wikiversity"
        case .wikivoyage:
            return "wikimedia-project-wikivoyage"
        case .mediawiki:
            return "wikimedia-project-mediawiki"
        case .wikispecies:
            return "wikimedia-project-wikispecies"
        }
    }
    
    public var languageCode: String? {
        switch self {
        case .commons:
            return nil
        case .wikidata:
            return nil
        case .wikiquote(let languageCode, _):
            return languageCode
        case .wikipedia(let languageCode, _, _):
            return languageCode
        case .wikibooks(let languageCode, _):
            return languageCode
        case .wiktionary(let languageCode, _):
            return languageCode
        case .wikisource(let languageCode, _):
            return languageCode
        case .wikinews(let languageCode, _):
            return languageCode
        case .wikiversity(let languageCode, _):
            return languageCode
        case .wikivoyage(let languageCode, _):
            return languageCode
        case .mediawiki:
            return nil
        case .wikispecies:
            return nil
        }
    }
    
    public init?(siteURL: URL) {
        
        let canonicalSiteURL = siteURL.canonical
        let siteURLString = canonicalSiteURL.absoluteString
        
        // Assign non-language specific project
        if siteURLString.contains(Configuration.Domain.mediaWiki) {
           self = .mediawiki
            return
        } else if siteURLString.contains(Configuration.Domain.wikispecies) {
           self = .wikispecies
           return
        } else if siteURLString.contains(Configuration.Domain.commons) || siteURLString.contains(Configuration.Domain.commonsBetaLabs) {
           self = .commons
           return
        } else if siteURLString.contains(Configuration.Domain.wikidata) || siteURLString.contains(Configuration.Domain.wikidataBetaLabs) {
           self = .wikidata
           return
        }
        
        guard let languageCode = canonicalSiteURL.wmf_languageCode else {
            return nil
        }
        
        if siteURLString.contains(Configuration.current.defaultSiteDomain) {
            self = .wikipedia(languageCode, "", nil)
        } else if siteURLString.contains(Configuration.Domain.wikiquote) {
            self = .wikiquote(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wikibooks) {
            self = .wikibooks(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wiktionary) {
            self = .wiktionary(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wiktionary) {
            self = .wiktionary(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wikisource) {
            self = .wikisource(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wikinews) {
            self = .wikinews(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wikiversity) {
            self = .wikiversity(languageCode, "")
        } else if siteURLString.contains(Configuration.Domain.wikivoyage) {
            self = .wikivoyage(languageCode, "")
        } else {
            return nil
        }
    }
    
    // MARK: Routing Helpers
    
    public var supportsNativeArticleTalkPages: Bool {
        // Can switch on this in the future if we add more projects that don't support them
        return true
    }
    
    public var supportsNativeUserTalkPages: Bool {
        // Can switch on this in the future if we add more projects that don't support them
        return true
    }
    
    public var supportsNativeDiffPages: Bool {
        switch self {
        case .wikipedia:
            return true
        default:
            return false
        }
    }
    
    public var mainNamespaceGoesToNativeArticleView: Bool {
        switch self {
        case .wikipedia:
            return true
        default:
            return false
        }
    }
    
    public var considersWikipediaNamespaceForRouting: Bool {
        switch self {
        case .wikipedia:
            return true
        default:
            return false
        }
    }
    
    public var considersWResourcePathsForRouting: Bool {
        switch self {
        case .wikipedia:
            return true
        default:
            return false
        }
    }
}
