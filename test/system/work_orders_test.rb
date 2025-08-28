require "application_system_test_case"

class WorkOrdersTest < ApplicationSystemTestCase
  setup do
    @work_order = work_orders(:one)
  end

  test "visiting the index" do
    visit work_orders_url
    assert_selector "h1", text: "Work orders"
  end

  test "should create work order" do
    visit work_orders_url
    click_on "New work order"

    fill_in "Asset", with: @work_order.asset_id
    fill_in "Description", with: @work_order.description
    fill_in "Scheduled for", with: @work_order.scheduled_for
    fill_in "Status", with: @work_order.status
    fill_in "Title", with: @work_order.title
    click_on "Create Work order"

    assert_text "Work order was successfully created"
    click_on "Back"
  end

  test "should update Work order" do
    visit work_order_url(@work_order)
    click_on "Edit this work order", match: :first

    fill_in "Asset", with: @work_order.asset_id
    fill_in "Description", with: @work_order.description
    fill_in "Scheduled for", with: @work_order.scheduled_for
    fill_in "Status", with: @work_order.status
    fill_in "Title", with: @work_order.title
    click_on "Update Work order"

    assert_text "Work order was successfully updated"
    click_on "Back"
  end

  test "should destroy Work order" do
    visit work_order_url(@work_order)
    accept_confirm { click_on "Destroy this work order", match: :first }

    assert_text "Work order was successfully destroyed"
  end
end
