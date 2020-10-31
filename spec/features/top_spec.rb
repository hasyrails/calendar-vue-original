require 'rails_helper'
require 'spec_helper'

describe 'トップページ', type: :system do
  describe "表示部分", js: true do

    before do
      visit '/'
    end
    
    # before ('@ChangeBrowserZoom') do
    #   page = Capybara::page
    #   page.execute_script("document.getElementsByTagName('html')[0].style['zoom'] = 0.1")
    # end

    it "（共通）トップページが表示されること" do
      expect(current_path).to eq "/"
      expect(page).to have_content("初志しか勝たん")
    end
    
    
    it "（共通？）ヘッダーからユーザー登録ページへ遷移できる" do
      find('.app-header-link-register').click
      assert_text 'ユーザー登録'
      expect(current_path).to eq "/register"
    end
    
    it "（共通）ヘッダーからログイン画面へ遷移できる" do
      find('.app-header-link-login').click
      assert_text 'ログイン'
      expect(current_path).to eq "/login"
    end
    
    it "（共通）ペンアイコンをクリックするとガントチャートページに遷移できる" do
      find('.linkicon-to-ganttchart-page').click
      expect(current_path).to eq "/schedules"
    end

    it "（共通）ペンアイコン上をマススホバーするとメッセージ吹き出しが現れる" do
      find('.linkicon-to-ganttchart-page').hover
      assert_text 'スケジュールを立てましょう！'
    end
    
    it "（共通）前月への移動ボタンでカレンダーの月を前月に変えることができる" do
      currentYYMM = Date.today.strftime('%Y/%m')
      prevYYMM = Date.today.prev_month.strftime('%Y/%m')
      assert_text currentYYMM
      find('.prev-month-button').click
      assert_text prevYYMM
    end

    it "（共通）次月への移動ボタンでカレンダーの月を次月に変えることができる" do
      currentYYMM = Date.today.strftime('%Y/%m')
      nextYYMM = Date.today.next_month.strftime('%Y/%m')
      assert_text currentYYMM
      find('.next-month-button').click
      assert_text nextYYMM
    end
    
    it "（非ログイン時）ヘッダーからゲストログインできる" do
      find('.app-header-link-guest-login').click
      assert_text 'ゲストさん'
      expect(page).to have_css '.user-icon'
    end
    
    it "（非ログイン時）カレンダーをクリックすると、説明メッセージが表示される" do
      find('.calendar').click
      assert_text 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
    end


    it "（ゲストログイン時）カレンダーをクリックすると、説明メッセージが表示される" do
      # ゲストログイン→ヘルパーメソッドで表現する
      find('.app-header-link-guest-login').click
      assert_text 'ゲストさん'
      expect(page).to have_css '.user-icon'

      find('.calendar').click
      assert_text 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
    end

  end
end
