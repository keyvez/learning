import Foundation

func randomWord() -> String {
  if let wordsFilePath = Bundle.main.path(forResource: "words3.txt", ofType: nil) {
    do {
      let wordsString = try String(contentsOfFile: wordsFilePath)

      let wordLines = wordsString.components(separatedBy: CharacterSet.newlines)

      return wordLines[Int(arc4random_uniform(UInt32(wordLines.count)))]
    } catch { // contentsOfFile throws an error
      print("Error: \(error)")

      return ""
    }
  }

  return ""
}
