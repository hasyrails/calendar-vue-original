require 'rails_helper'
require 'spec_helper'

describe 'トップページ', type: :system do

  describe '操作', js: true do
      
    context '共通' do
      before {
        visit '/schedules'
      }

      it "datepickerでクリックした日付にジャンプできる" do
        find('.datepicker').click
        expect(page).to have_css '.calendar'
        (all(".calendar-date")[10]).click
        expect(page).to have_selector '.ganttchart-date', text: '11'
      end

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
      before {
        visit '/schedules'
      }
      
      it "「完遂の軌跡」ボタンをクリックするとメッセージが現れる" do
        find('.locked-button-to-ganttchart-of-done').click
        expect(page).to have_css '.message', text: 'ユーザー登録・ログインすると使えるようになります！'
      end
    end
    
    context 'ゲストログイン時' do

      before{
        visit '/schedules'
        find('.app-header-link-guest-login').click
      }
      
      it "「完遂の軌跡」ボタンをクリックするとメッセージが現れる" do
        find('.locked-button-to-ganttchart-of-done').click
        expect(page).to have_css '.message', text: 'ユーザー登録・ログインすると使えるようになります！'
      end
      
      it 'サンプルカードの詳細ボタンを押すとモーダルが現れる' do
        (all('.show-sample-detail-button')[0]).click
        expect(page).to have_css '.sample-card-modal-content', text: 'サンプルです'
      end
    end
    
    context 'ログイン時' do
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
        page.driver.browser.switch_to.alert.accept
      }
      
      it "ToDoリストを追加できる" do
        (all(".list-add-form")[0]).set(add_list.title)
        find('#list-add-form').send_keys(:enter)
        expect(page).to have_css '.list', text: add_list.title
      end
      
      it "ToDoリストを削除できる" do
        (all(".delete-list-button")[0]).click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_css '.list'
      end
      
      it "ToDoカードを追加できる" do
        (all(".card-add-form")[0]).set(add_card.body)
        (all('.card-add-form')[0]).send_keys(:enter)
        expect(page).to have_css '.card', text: add_card.body
      end
      
      # ログイン4回目移行ログインできなくなる？
      # it "ToDoカードのタイトルをクリックすると更新フォームが現れる" do
      #   (all(".card-add-form")[0]).set(add_card.body)
      #   (all('.card-add-form')[0]).send_keys(:enter)
      #   find(".card-body").click
      #   (all('.card-body-form')[0]).set(update_card.body)
      #   (all('.card-body-form')[0]).send_keys(:enter)
      #   expect(page).to have_css '.card', text: update_card.body
      # end
      
      # it "ToDoカードを削除できる" do
      #   (all(".card-add-form")[0]).set(add_card.body)
      #   (all('.card-add-form')[0]).send_keys(:enter)
      #   expect(page).to have_css '.card', text: add_card.body
      #   (all(".delete-card-button")[0]).click
      #   page.driver.browser.switch_to.alert.accept
      #   expect(page).not_to have_css '.card'
      # end
    end
  end
end
