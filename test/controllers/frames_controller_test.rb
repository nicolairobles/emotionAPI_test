require 'test_helper'

class FramesControllerTest < ActionController::TestCase
  setup do
    @frame = frames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frame" do
    assert_difference('Frame.count') do
      post :create, frame: { anger: @frame.anger, contempt: @frame.contempt, disgust: @frame.disgust, fear: @frame.fear, happiness: @frame.happiness, neutral: @frame.neutral, sadness: @frame.sadness, surprise: @frame.surprise, video_id: @frame.video_id, video_timestamp: @frame.video_timestamp }
    end

    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should show frame" do
    get :show, id: @frame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frame
    assert_response :success
  end

  test "should update frame" do
    patch :update, id: @frame, frame: { anger: @frame.anger, contempt: @frame.contempt, disgust: @frame.disgust, fear: @frame.fear, happiness: @frame.happiness, neutral: @frame.neutral, sadness: @frame.sadness, surprise: @frame.surprise, video_id: @frame.video_id, video_timestamp: @frame.video_timestamp }
    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should destroy frame" do
    assert_difference('Frame.count', -1) do
      delete :destroy, id: @frame
    end

    assert_redirected_to frames_path
  end
end
