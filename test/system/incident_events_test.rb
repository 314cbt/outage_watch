require "application_system_test_case"

class IncidentEventsTest < ApplicationSystemTestCase
  setup do
    @incident_event = incident_events(:one)
  end

  test "visiting the index" do
    visit incident_events_url
    assert_selector "h1", text: "Incident events"
  end

  test "should create incident event" do
    visit incident_events_url
    click_on "New incident event"

    fill_in "Incident", with: @incident_event.incident_id
    fill_in "Kind", with: @incident_event.kind
    fill_in "Message", with: @incident_event.message
    fill_in "Occurred at", with: @incident_event.occurred_at
    click_on "Create Incident event"

    assert_text "Incident event was successfully created"
    click_on "Back"
  end

  test "should update Incident event" do
    visit incident_event_url(@incident_event)
    click_on "Edit this incident event", match: :first

    fill_in "Incident", with: @incident_event.incident_id
    fill_in "Kind", with: @incident_event.kind
    fill_in "Message", with: @incident_event.message
    fill_in "Occurred at", with: @incident_event.occurred_at
    click_on "Update Incident event"

    assert_text "Incident event was successfully updated"
    click_on "Back"
  end

  test "should destroy Incident event" do
    visit incident_event_url(@incident_event)
    accept_confirm { click_on "Destroy this incident event", match: :first }

    assert_text "Incident event was successfully destroyed"
  end
end
