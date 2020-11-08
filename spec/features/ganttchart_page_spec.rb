require 'rails_helper'
require 'spec_helper'

describe 'トップページ', type: :system do

  describe "表示", js: true do
    before do
      visit '/schedules'
    end
    
    context '共通' do 
      it "ガントチャートページが表示されること" do
        expect(current_path).to eq "/schedules"
      end
      
      it "ガントチャートが表示されている" do
        expect(page).to have_selector '.ganttchart'
      end

      it "ガントチャートヘッダーに日付移動用カレンダーアイコンが表示されている" do
        expect(page).to have_selector '.datepicker'
      end

      it "日付移動用カレンダーアイコンにマウスホバーすると吹き出しが現れる" do
        find('.datepicker').hover
        expect(page).to have_selector '.link-description-ballon', text: '選んだ日付へ'
        expect(page).to have_selector '.link-description-ballon', text: 'ジャンプ'
      end
      
      it "ガントチャートヘッダーにホーム画面へ戻るアイコンが表示されている" do
        expect(page).to have_selector '.home-link-icon'
      end
      
      it "ホームアイコンにマウスホバーすると吹き出しが現れる" do
        find('.home-link-icon').hover
        expect(page).to have_selector '.link-description-ballon', text: 'ホームへ戻る'
      end

      it "ToDoボードが表示されている" do
        expect(page).to have_selector '.todo-board'
      end
    end
    
    context '非ログイン時' do
      it "ToDoボードにはToDoリストは一つもない" do
        expect(page).not_to have_selector '.list'
        expect(page).not_to have_selector '.card'
      end
      
      it "リスト追加フォームが表示されていない" do
        expect(page).not_to have_selector '.addlist'
        expect(page).not_to have_content 'ToDoリストを追加'
      end
      
      it "ToDoボードにメッセージが表示されている" do
        expect(page).to have_selector '.slide'
        expect(page).to have_content 'ゲストログインするとお試し機能、ユーザー登録・ログインすると‥!?'
      end
    end
    
    context 'ゲストログイン時' do
      before{
        visit '/schedules'
        find('.app-header-link-guest-login').click
      }
      
      it "ToDoボードにサンプルToDoリストが表示されている" do
        expect(page).to have_selector '.list', text: 'サンプルです'
        expect(page).to have_selector '.card', text: 'サンプルです'
        expect(page).to have_selector '.list', text: '買い物'
        expect(page).to have_selector '.card', text: '服買おう'
        expect(page).to have_selector '.card', text: '夕食の食材'
      end
      
      it "リスト追加フォームが表示されていない" do
        expect(page).not_to have_selector '.addlist'
        expect(page).not_to have_content 'ToDoリストを追加'
      end
      
      it "カード追加フォームが表示されていない" do
        expect(page).not_to have_selector '.addcard'
        expect(page).not_to have_content 'ToDoカードを追加'
      end
      
      it "ガントチャートヘッダーに「完遂の軌跡」ボタンが表示されている" do
        expect(page).to have_selector '.ganttchart-header', text: '完遂の軌跡'
      end

      it "ToDoボードにメッセージが表示されている" do
        expect(page).to have_selector '.todo-board', text: 'をクリックしてカードを予定に追加しましょう！'
      end
    end
    
    context 'ログイン時' do
      # 途中でログイン不能になる？→Cardレコード作成で作られるユーザーidが干渉？
      # let(:login_user) { build(:user) }
      # let(:other_user) { build(:user) }
      # let(:list) { create(:list, user: login_user ) }
      # let(:other_list) { create(:list, user: other_user ) }
      # # let(:card) { create(:card, user: login_user, list: list ) }
      # # let(:other_card) { create(:card, user: other_user ) }

      # before{
      #   click_on 'ログイン'
      #   fill_in 'email', with: login_user.email
      #   fill_in 'password', with: login_user.password
      #   find('.login-btn').click
      # }
      
      # it "ToDoボードにログインユーザーの作成したToDoリストが表示されている" do
      #   visit '/schedules'
      #   expect(page).to have_selector '.list', text: list.title
      #   expect(page).not_to have_selector '.list', text: other_list.title
      # end
      
      let(:user){build(:user)}
      let(:add_list){build(:list)}
      let(:add_card){build(:card)}
      let(:update_card){build(:card, body: 'UpdateCard')}
      let(:schedule){build(:schedule)}

      before{
        visit '/schedules'
        click_on 'ログイン'
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        find('.login-btn').click
        visit '/schedules'
      }

      after{
        find('.app-header-link-logout').click
      }

      it "リスト追加フォームが表示されている" do
        expect(page).to have_selector '.addlist'
        # expect(page).to have_content 'ToDoリストを追加'
      end
      
      it "カード追加フォームが表示されている" do
        expect(page).to have_selector '.addcard'
        # expect(page).to have_content 'ToDoカードを追加'
      end
      
      it "ガントチャートヘッダーに「完遂の軌跡」ボタンが表示されている" do
        expect(page).to have_selector '.ganttchart-header', text: '完遂の軌跡'
      end
    end
  end
    
  describe 'ページ遷移' do
    # before do
    #   visit '/'
    # end

    # context '共通' do
    #   it "ヘッダーからログイン画面へ遷移できる" do
    #     find('.app-header-link-login').click
    #     assert_text 'ログイン'
    #     expect(current_path).to eq "/login"
    #   end
      
    #   it "ペンアイコンをクリックするとガントチャートページに遷移できる" do
    #     find('.linkicon-to-ganttchart-page').click
    #     expect(current_path).to eq "/schedules"
    #   end
    # end

    # context '非ログイン時' do
    #   it "ヘッダーからユーザー登録ページへ遷移できる" do
    #     find('.app-header-link-register').click
    #     assert_text 'ユーザー登録'
    #     expect(current_path).to eq "/register"
    #   end
    # end

    # context 'ゲストログイン時' do
    #   it "ヘッダーからユーザー登録ページへ遷移できる" do
    #     find('.app-header-link-register').click
    #     assert_text 'ユーザー登録'
    #     expect(current_path).to eq "/register"
    #   end
    # end

    # context 'ログイン時' do
    #   # ログイン時は「共通」に含まれている
    #   # it '' do
    #   # end
    # end
  end
end
