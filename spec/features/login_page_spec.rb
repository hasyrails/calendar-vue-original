require 'rails_helper'
require 'spec_helper'

describe 'ログインページ', type: :system do
  describe "ユーザー名入力ページ（ユーザー登録：Step1）", js: true do

    before do
      visit '/login'
      create(:user)
    end
    
    it "（共通）ページが表示されること" do
      expect(current_path).to eq "/login"
      expect(page).to have_content("ログイン")
    end
    
    
    it "（共通）ログインが成功する" do
      fill_in('email', with: 'test@example.com')
      fill_in('password', with: 'password')
      find('.login-btn').click
      assert_text 'ログインしました'
      expect(current_path).to eq "/"
      expect(page).to have_css '.calendar'
    end

    it "（共通）ログインが失敗する" do
      fill_in('email', with: 'test')
      fill_in('password', with: 'test')
      find('.login-btn').click
      assert_text 'ログインできませんでした'
    end

    it "（共通）メールアドレスのバリデーションが現れる:空入力" do
      fill_in('email', with: '')
      assert_text '入力必須の項目です'
    end

    it "（共通）パスワードのバリデーションが現れる:空入力" do
      fill_in('password', with: '')
      assert_text '入力必須の項目です'
    end
    

  end
end
