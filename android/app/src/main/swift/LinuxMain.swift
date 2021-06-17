// Generate by using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// NOTHING OF THIS WORKS, use it as a starting off point


import XCTest
@testable import BreezeCoreTests



extension WeatherDatabaseTest {
  static var allTests = [
	  ("testDefaults", testDefaults),
  	  ("testAddLocation", testAddLocation),
  	  ("testRemoveLocation", testRemoveLocation),
  	  ("testClearLocation", testClearLocation),
	]

}

extension WeatherRepositoryTest {
  static var allTests = [
	  ("testLoadSavedLocations", testLoadSavedLocations),
  	  ("testAddLocationToSaved", testAddLocationToSaved),
  	  ("testRemoveSavedLocation", testRemoveSavedLocation),
  	  ("testSearchLocationsSuccessful", testSearchLocationsSuccessful),
  	  ("testSearchLocationsFail", testSearchLocationsFail),
  	  ("testWeatherSuccessful", testWeatherSuccessful),
  	  ("testWeatherFail", testWeatherFail),
	]

}


XCTMain([
		testCase(WeatherDatabaseTest.allTests),
		testCase(WeatherRepositoryTest.allTests),
])
