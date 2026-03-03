import XCTest
@testable import MyCity2 // ÄNDRA DENNA TILL DITT NYA APPNAMN!

final class MyCity2Tests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testJSONDecoding() throws {
        let jsonString = """
        {
            "events": [],
            "hotels": [],
            "stores": [],
            "restaurants": []
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        XCTAssertNoThrow(try decoder.decode(AppData.self, from: jsonData), "The app should be able to decode the JSON even if arrays are empty!")
    }
    @MainActor
    func testOneDayBeforeReminder() async throws {
            // 1. fake event for March 15, 2026
            let event = EventData(
                id: 1,
                title: "Test Music Fest",
                description: "Music",
                location: "Jönköping",
                date: "2026-03-15",
                time: "19:00",
                image: "",
                category: "Music",
                attendeesCount: 0
            )
            
        let viewModel = await EventViewModel(event: event)
            viewModel.gettingReminder = true // User wants a reminder
            
            // 2. här kör jag app logic
            await viewModel.scheduleNotification()
            
            // 3. här kollar jag om systmet schemalagd en notification
            let center = UNUserNotificationCenter.current()
            let requests = await center.pendingNotificationRequests()
            
            XCTAssertTrue(requests.count > 0, "SUCCESS: A reminder was scheduled!")
        }
    @MainActor
    func testDataConsistency() async {
        let viewModel = EventsViewModel()
        // First load
        await viewModel.loadEvents()
        let firstCount = viewModel.events.count
        
        // Second load
        await viewModel.loadEvents()
        let secondCount = viewModel.events.count
        XCTAssertEqual(firstCount, secondCount, "The number of events should stay the same if we load twice.")
    }
}
