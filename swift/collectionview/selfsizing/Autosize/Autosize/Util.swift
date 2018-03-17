import Foundation

func punctuate() -> Bool {
  return arc4random_uniform(10) < 2 ? true: false
}

func quantify() -> Bool {
  return arc4random_uniform(20) < 2 ? true: false
}

func vowel() -> Bool {
  return arc4random_uniform(26) < 5 ? true: false
}

func randFrom(_ letters: String) -> String {
  let randomIndex = Int(arc4random_uniform(UInt32(letters.characters.count)))
  return String(letters[letters.characters.index(letters.startIndex, offsetBy: randomIndex)])
}

func randMiddlePunctuation() -> String {
  let middlePunctuation: String = ",;"
  return randFrom(middlePunctuation)
}

func randNumber() -> String {
  var randomString = String()
  let numbers: String = "0123456789"
  let randLength = Int(arc4random_uniform(4) + 1)
  for _ in 1...randLength {
    randomString += randFrom(numbers)
  }
  return randomString
}

func randEndPunctuation() -> String {
  let endPunctuation: String = "!."
  return randFrom(endPunctuation)
}

func randVowel() -> String {
  let vowels: String = "aaaaaaaaaeeeeeeeeeeeeeiiiiiiiioooooooouuu"
  return randFrom(vowels)
}

func randConsonent() -> String {
  let consonents: String = "bbcccdddddfffgghhhhhhjkllllmmmnnnnnnnppqrrrrrrrsssssssttttttttttvwwxyyyz"
  return randFrom(consonents)
}

func randMiddleLetter() -> String {
  return vowel() ? randVowel() : randConsonent()
}

func randStartingLetter() -> String {
  let letter = vowel() ? randVowel() : randConsonent()
  return letter.uppercased()
}

func randomStringWithSentenceLength (_ len: UInt32) -> String {
  var randomString = String()

  let numWords = Int(arc4random_uniform(len) + 1)
  randomString += randStartingLetter()
  for i in 0...numWords {
    let numLetters = Int(arc4random_uniform(6) + 1)
    if i > 0 {
      randomString += " "
    }
    for _ in 0...numLetters {
      randomString += randMiddleLetter()
    }
    randomString += punctuate() ? randMiddlePunctuation() : ""
    let quantity = quantify() ? randNumber() : ""
    randomString += quantity
  }
  randomString += randEndPunctuation()

  return randomString as String
}
