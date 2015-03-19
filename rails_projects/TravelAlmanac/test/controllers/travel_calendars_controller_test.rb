require 'test_helper'

class TravelCalendarsControllerTest < ActionController::TestCase
  setup do
    @travel_calendar = travel_calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_calendar" do
    assert_difference('TravelCalendar.count') do
      post :create, travel_calendar: { location_id: @travel_calendar.location_id, month_id: @travel_calendar.month_id }
    end

    assert_redirected_to travel_calendar_path(assigns(:travel_calendar))
  end

  test "should show travel_calendar" do
    get :show, id: @travel_calendar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel_calendar
    assert_response :success
  end

  test "should update travel_calendar" do
    patch :update, id: @travel_calendar, travel_calendar: { location_id: @travel_calendar.location_id, month_id: @travel_calendar.month_id }
    assert_redirected_to travel_calendar_path(assigns(:travel_calendar))
  end

  test "should destroy travel_calendar" do
    assert_difference('TravelCalendar.count', -1) do
      delete :destroy, id: @travel_calendar
    end

    assert_redirected_to travel_calendars_path
  end
end
