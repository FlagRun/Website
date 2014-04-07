require 'test_helper'

class System::NewsControllerTest < ActionController::TestCase
  setup do
    @system_news = system_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_news" do
    assert_difference('System::News.count') do
      post :create, system_news: { body: @system_news.body, published_at: @system_news.published_at, oline: @system_news.roolinetags: @system_news.tags, title: @system_news.title, user_id: @system_news.user_id }
    end

    assert_redirected_to system_news_path(assigns(:system_news))
  end

  test "should show system_news" do
    get :show, id: @system_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_news
    assert_response :success
  end

  test "should update system_news" do
    patch :update, id: @system_news, system_news: { body: @system_news.body, published_at: @system_news.published_at, roleolineystem_news.role_id, tags: @system_news.tags, title: @system_news.title, user_id: @system_news.user_id }
    assert_redirected_to system_news_path(assigns(:system_news))
  end

  test "should destroy system_news" do
    assert_difference('System::News.count', -1) do
      delete :destroy, id: @system_news
    end

    assert_redirected_to system_news_index_path
  end
end
