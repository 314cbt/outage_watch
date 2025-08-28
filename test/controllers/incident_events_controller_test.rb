require "test_helper"

class IncidentEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incident_event = incident_events(:one)
  end

  test "should get index" do
    get incident_events_url
    assert_response :success
  end

  test "should get new" do
    get new_incident_event_url
    assert_response :success
  end

  test "should create incident_event" do
    assert_difference("IncidentEvent.count") do
      post incident_events_url, params: { incident_event: { incident_id: @incident_event.incident_id, kind: @incident_event.kind, message: @incident_event.message, occurred_at: @incident_event.occurred_at } }
    end

    assert_redirected_to incident_event_url(IncidentEvent.last)
  end

  test "should show incident_event" do
    get incident_event_url(@incident_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_incident_event_url(@incident_event)
    assert_response :success
  end

  test "should update incident_event" do
    patch incident_event_url(@incident_event), params: { incident_event: { incident_id: @incident_event.incident_id, kind: @incident_event.kind, message: @incident_event.message, occurred_at: @incident_event.occurred_at } }
    assert_redirected_to incident_event_url(@incident_event)
  end

  test "should destroy incident_event" do
    assert_difference("IncidentEvent.count", -1) do
      delete incident_event_url(@incident_event)
    end

    assert_redirected_to incident_events_url
  end
end
