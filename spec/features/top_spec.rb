require 'rails_helper'
require 'spec_helper'

describe 'トップページ', type: :system do
  describe "表示部分", js: true do
    let(:user) { create(:user) }

    before do
      visit '/'
    end
    
    context '共通' do 
      it "トップページが表示されること" do
        expect(current_path).to eq "/"
      end
      
      it "ヘッダータイトルが表示されている" do
        expect(page).to have_content("初志しか勝たん")
        expect(page).to have_selector '.app-header-title'
      end
      
      it "ペンアイコン上をマススホバーするとメッセージ吹き出しが現れる" do
        find('.linkicon-to-ganttchart-page').hover
        assert_text 'スケジュールを立てましょう！'
      end
    end
    
    context '非ログイン時' do
      it "ヘッダーにはゲストアイコンは表示されていない" do
        expect(page).not_to have_selector '.user-name'
        expect(page).not_to have_css '.user-icon'
      end
      
      it "ヘッダーに「ゲストログイン」が表示されている" do
        expect(page).to have_content("ゲストログイン")
        expect(page).to have_selector '.app-header-link-guest-login'
      end
      
      it "ヘッダーに「ユーザー登録」が表示されている" do
        expect(page).to have_content("ユーザー登録")
        expect(page).to have_selector '.app-header-link-register'
      end

      it "ヘッダーに「ログイン」が表示されている" do
        expect(page).to have_content("ログイン")
        expect(page).to have_selector '.app-header-link-login'
      end
      

      it "カレンダーをクリックすると、説明メッセージが表示される" do
        find('.calendar').click
        assert_text 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
      end
    end
    
    context 'ゲストログイン時' do
      before{
        visit '/'
        find('.app-header-link-guest-login').click
      }
      
      it "ゲストアイコンがヘッダーに表示される" do
        expect(page).to have_selector '.user-name', text: 'ゲストさん'
        expect(page).to have_css '.user-icon'
      end

      it "ヘッダーに「ログアウト（ゲスト）」が表示されている" do
        expect(page).to have_content("ログアウト（ゲスト）")
        expect(page).to have_selector '.app-header-link-guest-logout'
      end
      
      it "ヘッダーに「ユーザー登録」が表示されている" do
        expect(page).to have_content("ユーザー登録")
        expect(page).to have_selector '.app-header-link-register'
      end

      it "ヘッダーに「ログイン」が表示されている" do
        expect(page).to have_content("ログイン")
        expect(page).to have_selector '.app-header-link-login'
      end
      
      it "カレンダーをクリックすると、説明メッセージが表示される" do
        find('.calendar').click
        assert_text 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
      end
      
    end
    
    context 'ログイン時' do
      before{
        click_on 'ログイン'
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        find('.login-btn').click
      }
        before{
          create(:user, image: '')
        }
        it "ヘッダーに「ログアウト」が表示されている" do
          expect(page).to have_content("ログアウト")
          expect(page).to have_selector '.app-header-link-logout'
        end
        
        it "ヘッダーにユーザー名が表示される" do
          expect(page).to have_content user.name
        end
        
        it "カレンダーをクリックしても、説明メッセージは表示されない" do
          find('.calendar').click
          expect(page).not_to have_content 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
        end
      
      # factoryデータで画像を表示できず
      # context 'ユーザーアイコンを登録していない場合' do
      #   before{
      #     create(:user, image: '')
      #   }
        
      #   it "ヘッダーにユーザーアイコン(仮)が表示される" do
      #     expect(page).to have_selector '.user-icon'
      #   end
      # end

      # context 'ユーザーアイコンを登録している場合' do
        
      #   fit "ヘッダーにユーザーアイコンが表示される" do
      #     expect(page).to have_selector '.user-image'
      #     sleep 10
      #   end
      # end
    end
  end
    
  describe '操作' do
    let(:user) {create(:user)}
    before do
      visit '/'
    end
    
    context '共通' do
      it "前月への移動ボタンでカレンダーの月を前月に変えることができる" do
        currentYYMM = Date.today.strftime('%Y/%m')
        prevYYMM = Date.today.prev_month.strftime('%Y/%m')
        assert_text currentYYMM
        find('.prev-month-button').click
        assert_text prevYYMM
      end
      
      it "次月への移動ボタンでカレンダーの月を次月に変えることができる" do
        currentYYMM = Date.today.strftime('%Y/%m')
        nextYYMM = Date.today.next_month.strftime('%Y/%m')
        assert_text currentYYMM
        find('.next-month-button').click
        assert_text nextYYMM
      end
    end

    context '非ログイン時' do
      it "ヘッダーからゲストログインできる" do
        find('.app-header-link-guest-login').click
        assert_text 'ゲストさん'
        expect(page).to have_css '.user-icon'
      end
    end
    
    context 'ゲストログイン時' do
      before{
        find('.app-header-link-guest-login').click
      }
      
      it "ヘッダーからゲストログアウトできる" do
        find('.app-header-link-guest-logout').click
        expect(page).not_to have_css '.user-icon'
        expect(page).to have_content 'ゲストログイン'
      end
    end
    
    context 'ログイン時' do
      before{
        click_on 'ログイン'
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        find('.login-btn').click
      }
      it "ヘッダーからログアウトできる" do
        find('.app-header-link-logout').click
        expect(page.driver.browser.switch_to.alert.text).to eq "ログアウトしますか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_css '.user-icon'
      end
    end
  end

  describe 'ページ遷移' do
    before do
      visit '/'
    end

    context '共通' do
      it "ヘッダーからログイン画面へ遷移できる" do
        find('.app-header-link-login').click
        assert_text 'ログイン'
        expect(current_path).to eq "/login"
      end
      
      it "ペンアイコンをクリックするとガントチャートページに遷移できる" do
        find('.linkicon-to-ganttchart-page').click
        expect(current_path).to eq "/schedules"
      end
    end

    context '非ログイン時' do
      it "ヘッダーからユーザー登録ページへ遷移できる" do
        find('.app-header-link-register').click
        assert_text 'ユーザー登録'
        expect(current_path).to eq "/register"
      end
    end

    context 'ゲストログイン時' do
      it "ヘッダーからユーザー登録ページへ遷移できる" do
        find('.app-header-link-register').click
        assert_text 'ユーザー登録'
        expect(current_path).to eq "/register"
      end
    end

    context 'ログイン時' do
      # ログイン時は「共通」に含まれている
      # it '' do
      # end
    end
  end
end
