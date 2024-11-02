import Foundation
import FastReplace
import CodepointMacro

func replacingSeveralCharacters(_ text: String) -> String {
    text
        .replacing("a", with: "∫")
        .replacing("b", with: "∫")
        .replacing("c", with: "∫")
        .replacing("d", with: "∫")
        .replacing("e", with: "∫")
        .replacing("f", with: "∫")
        .replacing("g", with: "∫")
        .replacing("h", with: "∫")
        .replacing("i", with: "∫")
        .replacing("j", with: "∫")
}

func replacingSeveralCharactersToString(_ text: String) -> String {
    text
        .replacing("a", with: "X∫")
        .replacing("b", with: "X∫")
        .replacing("c", with: "X∫")
        .replacing("d", with: "X∫")
        .replacing("e", with: "X∫")
        .replacing("f", with: "X∫")
        .replacing("g", with: "X∫")
        .replacing("h", with: "X∫")
        .replacing("i", with: "X∫")
        .replacing("j", with: "X∫")
}

let scalarMap: [UnicodeScalar:UnicodeScalar] = [
    UnicodeScalar("a"): UnicodeScalar("∫"),
    UnicodeScalar("b"): UnicodeScalar("∫"),
    UnicodeScalar("c"): UnicodeScalar("∫"),
    UnicodeScalar("d"): UnicodeScalar("∫"),
    UnicodeScalar("e"): UnicodeScalar("∫"),
    UnicodeScalar("f"): UnicodeScalar("∫"),
    UnicodeScalar("g"): UnicodeScalar("∫"),
    UnicodeScalar("h"): UnicodeScalar("∫"),
    UnicodeScalar("i"): UnicodeScalar("∫"),
    UnicodeScalar("j"): UnicodeScalar("∫"),
]

let scalarToStringMap: [UnicodeScalar:String] = [
    UnicodeScalar("a"): "X∫",
    UnicodeScalar("b"): "X∫",
    UnicodeScalar("c"): "X∫",
    UnicodeScalar("d"): "X∫",
    UnicodeScalar("e"): "X∫",
    UnicodeScalar("f"): "X∫",
    UnicodeScalar("g"): "X∫",
    UnicodeScalar("h"): "X∫",
    UnicodeScalar("i"): "X∫",
    UnicodeScalar("j"): "X∫",
]

let codepointMap: [UInt32:UInt32] = [
    #codepoint("a"): #codepoint("∫"),
    #codepoint("b"): #codepoint("∫"),
    #codepoint("c"): #codepoint("∫"),
    #codepoint("d"): #codepoint("∫"),
    #codepoint("e"): #codepoint("∫"),
    #codepoint("f"): #codepoint("∫"),
    #codepoint("g"): #codepoint("∫"),
    #codepoint("h"): #codepoint("∫"),
    #codepoint("i"): #codepoint("∫"),
    #codepoint("j"): #codepoint("∫"),
]

let codepointToStringMap: [UInt32:String] = [
    #codepoint("a"): "X∫",
    #codepoint("b"): "X∫",
    #codepoint("c"): "X∫",
    #codepoint("d"): "X∫",
    #codepoint("e"): "X∫",
    #codepoint("f"): "X∫",
    #codepoint("g"): "X∫",
    #codepoint("h"): "X∫",
    #codepoint("i"): "X∫",
    #codepoint("j"): "X∫",
]

func measure(text : String, _ f: (String) -> String, n: Int) -> Duration {
    print("tic...", terminator: "")
    
    let clock = ContinuousClock()

    let result = clock.measure {
        for _ in 1...n {
            _ = f(text)
        }
    }
    
    print(" toc.")
    return result
}

let n: Int = if CommandLine.arguments.count > 1, let number = Int(CommandLine.arguments[1]) { number } else { 1000 }
let nForSingle = 10 * n
print("\(nForSingle) runs for replacements with singletons, \(n) runs else.")

let text = "hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello"

let regex = /e/

let durationRegexInFunction = measure(text: text, { $0.replacing(/e/, with: "∫") }, n: nForSingle).description
let durationGlobalRegex = measure(text: text, { $0.replacing(regex, with: "∫") }, n: nForSingle).description
let durationRegexInFunctionWithCodepointMatching = measure(text: text, { $0.replacing(/e/, with: "∫") }, n: nForSingle).description
let durationGlobalRegexWithCodepointMatching = measure(text: text, { $0.replacing(regex, with: "∫") }, n: nForSingle).description

let durationSingleCharacter = measure(text: text, { $0.replacing("e", with: "∫") }, n: nForSingle).description
let durationSingleScalar = measure(text: text, { $0.replacing(UnicodeScalar("e"), with: UnicodeScalar("∫")) }, n: nForSingle).description
let durationSingleCodepoint = measure(text: text, { $0.replacing(#codepoint("e"), with: #codepoint("∫")) }, n: nForSingle).description

let durationSingleCharacterToString = measure(text: text, { $0.replacing("e", with: "X∫") }, n: nForSingle).description
let durationSingleScalarToString = measure(text: text, { $0.replacing(UnicodeScalar("e"), with: "X∫") }, n: nForSingle).description
let durationSingleCodepointToString = measure(text: text, { $0.replacing(#codepoint("e"), with: "X∫") }, n: nForSingle).description

let duractionSeveralCharacters = measure(text: text, { replacingSeveralCharacters($0) }, n: n).description
let duractionSeveralScalars = measure(text: text, { $0.replacing(scalarMap) }, n: n).description
let duractionSeveralCodepoints = measure(text: text, { $0.replacing(codepointMap) }, n: n).description

let duractionSeveralCharactersToString = measure(text: text, { replacingSeveralCharactersToString($0) }, n: n).description
let duractionSeveralScalarsToString = measure(text: text, { $0.replacing(scalarToStringMap) }, n: n).description
let duractionSeveralCodepointsToString = measure(text: text, { $0.replacing(codepointToStringMap) }, n: n).description

let runsTitle = "# runs"
let charactersTitle = "characters"
let scalarsTitle = "scalars"
let codepointsTitle = "codepoints"
let runsInfoLength = [
    runsTitle,
    n.description,
    nForSingle.description
].map{ $0.count }.max()!

let maxDurationInfoLength = [
    "characters", "scalars", "codepoints",
    durationSingleCharacter, durationSingleScalar, durationSingleCodepoint,
    durationSingleCharacterToString, durationSingleScalarToString, durationSingleCodepointToString,
    duractionSeveralCharacters, duractionSeveralScalars, duractionSeveralCodepoints,
    duractionSeveralCharactersToString, duractionSeveralScalarsToString, duractionSeveralCodepointsToString
].map{ $0.description.count }.max()!

let hyphensForRuns = String(repeating: "-", count: runsInfoLength)
let hyphensForDuration = String(repeating: "-", count: maxDurationInfoLength)

print(
    """
    
                            | \(runsTitle.withSpacesAround(runsInfoLength)) | \(charactersTitle.withSpacesAround(maxDurationInfoLength)) | \(scalarsTitle.withSpacesAround(maxDurationInfoLength)) | \(codepointsTitle.withSpacesAround(maxDurationInfoLength))
    ------------------------|-\(hyphensForRuns)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-
    single to single        | \(nForSingle.withSpacesBefore(runsInfoLength)) | \(durationSingleCharacter.withSpacesAfter(maxDurationInfoLength)) | \(durationSingleScalar.withSpacesAfter(maxDurationInfoLength)) | \(durationSingleCodepoint.withSpacesAfter(maxDurationInfoLength))
    ------------------------|-\(hyphensForRuns)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-
    single to String        | \(nForSingle.withSpacesBefore(runsInfoLength)) | \(durationSingleCharacterToString.withSpacesAfter(maxDurationInfoLength)) | \(durationSingleScalarToString.withSpacesAfter(maxDurationInfoLength)) | \(durationSingleCodepointToString.withSpacesAfter(maxDurationInfoLength))
    ------------------------|-\(hyphensForRuns)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-
    several, each to single | \(n.withSpacesBefore(runsInfoLength)) | \(duractionSeveralCharacters.withSpacesAfter(maxDurationInfoLength)) | \(duractionSeveralScalars.withSpacesAfter(maxDurationInfoLength)) | \(duractionSeveralCodepoints.withSpacesAfter(maxDurationInfoLength))
    ------------------------|-\(hyphensForRuns)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-
    several, each to String | \(n.withSpacesBefore(runsInfoLength)) | \(duractionSeveralCharactersToString.withSpacesAfter(maxDurationInfoLength)) | \(duractionSeveralScalarsToString.withSpacesAfter(maxDurationInfoLength)) | \(duractionSeveralCodepointsToString.withSpacesAfter(maxDurationInfoLength))
    ------------------------|-\(hyphensForRuns)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-|-\(hyphensForDuration)-
    
    
                                                       | replacement of a single letter via regular expression (\(n) runs)
    ---------------------------------------------------|-------------------------------------------------------------------
    regex in function                                  | \(durationRegexInFunction)
    duration global regex                              | \(durationGlobalRegex)
    duration regex in function with codepoint matching | \(durationRegexInFunctionWithCodepointMatching)
    duration global regex with codepoint matching      | \(durationGlobalRegexWithCodepointMatching)
    
    """
)

extension CustomStringConvertible {
    
    func withSpacesBefore(_ length: Int) -> String {
        let s = String(self.description)
        return "\(String(repeating: " ", count: max(0,length-s.count)))\(s)"
    }
    
    func withSpacesAfter(_ length: Int) -> String {
        let s = String(self.description)
        return "\(s)\(String(repeating: " ", count: max(0,length-s.count)))"
    }
    
    func withSpacesAround(_ length: Int) -> String {
        let s = String(self.description)
        let allSpaces = max(0,length-s.count)
        let right = allSpaces / 2
        let left = allSpaces - right
        return "\(String(repeating: " ", count: left))\(s)\(String(repeating: " ", count: right))"
    }
    
}
