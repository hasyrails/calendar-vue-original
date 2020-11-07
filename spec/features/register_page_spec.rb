require 'rails_helper'
require 'spec_helper'

describe 'ユーザー登録ページ(マルチステップ入力ページ)', type: :system do
  let(:user) { build(:user) }
  describe "ユーザー名入力ページ（ユーザー登録：Step1）", js: true do

    before do
      visit '/register'
    end
    
    it "（共通）ページが表示されること" do
      expect(current_path).to eq "/register"
      expect(page).to have_content("ユーザー登録")
    end
    
    
    it "（共通）ユーザー名入力のバリデーションが現れる" do
      fill_in('name', with: '')
      assert_text '入力必須の項目です'
    end

    it "（共通）ユーザー名入力のバリデーションが現れない" do
      fill_in 'name', with: user.name
      assert_no_text '入力必須の項目です'
    end
    
    it "（共通）ユーザー名入力ページでは「戻る」ボタンは表示されない" do
      assert_no_text '戻る'
      expect(page).not_to have_css '.register-step-prev-button-label'
      expect(page).not_to have_css '.register-step-prev-button'
    end

    it "（共通）「次へ」ボタンでStep2(メールアドレス入力ページ)へ進める" do
      assert_text '次へ'
      expect(page).to have_css '.register-step-next-button-label'
      expect(page).to have_css '.register-step-next-button'
      find('.register-step-next-button').click
      assert_text 'Step2'
      assert_text 'メールアドレスを入力してください'
      expect(page).to have_field('email')
    end
  end
  
  describe "メールアドレス入力ページ（ユーザー登録：Step2）", js: true do
    
    before do
      visit '/register'
      find('.register-step-next-button').click
    end
    
    it "（共通）ページが表示されること" do
      expect(current_path).to eq "/register"
      expect(page).to have_content("Step2")
    end
    
    
    it "（共通）メールアドレスのバリデーションが現れる:空入力" do
      fill_in('email', with: '')
      assert_text '入力必須の項目です'
    end

    it "（共通）メールアドレスのバリデーションが現れる:形式相違" do
      fill_in('email', with: 'examplemail')
      assert_text '正しいメールアドレスの形式で入力してください'
    end

    it "（共通）メールアドレス入力のバリデーションが現れない" do
      fill_in 'email', with: user.email
      assert_no_text '入力必須の項目です'
      assert_no_text '正しいメールアドレスの形式で入力してください'
    end
    
    it "（共通）メールアドレス入力ページでは「戻る」「次へ」ボタンどちらも表示されている" do
      assert_text '戻る'
      expect(page).to have_css '.register-step-prev-button-label'
      expect(page).to have_css '.register-step-prev-button'
      assert_text '次へ'
      expect(page).to have_css '.register-step-next-button-label'
      expect(page).to have_css '.register-step-next-button'
    end

    it "（共通）「戻る」ボタンでStep1(ユーザー名入力ページ)へ戻ることができる" do
      find('.register-step-prev-button').click
      assert_text 'Step1'
      assert_text 'ユーザー名を入力してください'
      expect(page).to have_field('name')
    end

    it "（共通）「次へ」ボタンでStep3(アイコン登録ページ)へ進める" do
      find('.register-step-next-button').click
      assert_text 'Step3'
      assert_text 'ユーザーアイコンを登録しましょう'
      expect(page).to have_field('file')
    end
  end
  
  describe "アイコン登録ページ（ユーザー登録：Step3）", js: true do
    
    before do
      visit '/register'
      find('.register-step-next-button').click
      find('.register-step-next-button').click
    end
    
    it "（共通）ページが表示されること" do
      expect(current_path).to eq "/register"
      expect(page).to have_content("Step3")
    end
    
    
    it "（共通）png画像がbase64で暗号化されてアップロードできる・表示される" do
      attach_file('file', 'spec/fixtures/testicon.png')
      click_on 'アップロード'
      expect(page).to have_css("img[src*='base64']")
      assert_text 'ユーザーアイコンを登録しました'
    end
    
    it "（共通）jpeg画像がbase64で暗号化されてアップロードできる" do
      attach_file('file', 'spec/fixtures/testicon.jpeg')
      click_on 'アップロード'
      expect(page).to have_css("img[src*='base64']")
      assert_text 'ユーザーアイコンを登録しました'
    end
    
    # pdfファイルは許容していないがなぜかテストパスしてしまう
    # fit "（共通）pdf画像がアップロードできない" do
    #   attach_file('file', 'spec/fixtures/testicon.pdf')
    #   click_on 'アップロード'
    #   expect(page).to have_css("img[src*='base64']")
    #   sleep 5
    # end
    
    it "（共通）アイコン登録ページでは「戻る」「次へ」ボタンどちらも表示されている" do
      assert_text '戻る'
      expect(page).to have_css '.register-step-prev-button-label'
      expect(page).to have_css '.register-step-prev-button'
      assert_text '次へ'
      expect(page).to have_css '.register-step-next-button-label'
      expect(page).to have_css '.register-step-next-button'
    end
    
    it "（共通）「戻る」ボタンでStep2(メールアドレス入力ページ)へ戻ることができる" do
      find('.register-step-prev-button').click
      assert_text 'Step2'
      assert_text 'メールアドレスを入力してください'
      expect(page).to have_field('email')
    end
    
    it "（共通）「次へ」ボタンでStep4(パスワード入力ページ)へ進める" do
      find('.register-step-next-button').click
      assert_text 'Step4'
      assert_text 'パスワードを入力してください'
      expect(page).to have_field('password')
      expect(page).to have_field('password_confirmation')
    end
  end
  
  describe "パスワード入力ページ（ユーザー登録：Step4）", js: true do
    
    before do
      visit '/register'
      find('.register-step-next-button').click
      find('.register-step-next-button').click
      find('.register-step-next-button').click
    end
    
    it "（共通）ページが表示されること" do
      expect(current_path).to eq "/register"
      expect(page).to have_content("Step4")
    end
    
    it "（共通）パスワードのバリデーションが現れる:空入力" do
      fill_in('password', with: '')
      assert_text '入力必須の項目です'
    end
    
    it "（共通）パスワード確認のバリデーションが現れる:空入力" do
      fill_in('password_confirmation', with: '')
      assert_text '入力必須の項目です'
    end
    
    it "（共通）パスワード確認のバリデーションが現れる:入力不一致" do
      fill_in 'password', with: user.password
      fill_in('password_confirmation', with: 'pasiword')
      assert_text '入力内容が一致していません'
    end
    
    it "（共通）「戻る」ボタンでStep3(アイコン登録ページ)へ戻ることができる" do
      find('.register-step-prev-button').click
      assert_text 'Step3'
      assert_text 'アイコンを登録しましょう'
      expect(page).to have_field('file')
    end
    
    it "（共通）「次へ」ボタンで入力内容確認画面へ進める" do
      find('.register-step-next-button').click
      assert_text 'Step5'
      assert_text 'ご入力内容'
    end
  end
  
  describe "入力内容確認画面、ログイン成功の場合", js: true do
    
    before do
      visit '/register'
      fill_in 'name', with: user.name
      find('.register-step-next-button').click
      fill_in 'email', with: user.email
      find('.register-step-next-button').click
      attach_file('file', 'spec/fixtures/testicon.png')
      click_on 'アップロード'
      find('.register-step-next-button').click
      fill_in 'password', with: user.password
      fill_in 'password_confirmation', with: user.password_confirmation
      find('.register-step-next-button').click
    end
    
    
    it "入力内容した内容が表示されている" do
      assert_text user.name
      assert_text user.email
      expect(page).to have_css("img[src*='base64']")
      assert_text '●'
    end
    
    it "（共通）ユーザー登録に成功してログイン画面へ遷移する" do
      find('.register-btn').click
      sleep 3
      expect(current_path).to eq "/login"
      expect(page).to have_content("ログイン")
      assert_text 'ユーザー登録に成功しました'
    end
    
  end

  describe "入力内容確認画面、ログイン失敗の場合", js: true do
    
    before do
      visit '/register'
      fill_in('name', with: '')
      find('.register-step-next-button').click
      fill_in('email', with: 'test@example.com')
      find('.register-step-next-button').click
      attach_file('file', 'spec/fixtures/testicon.png')
      click_on 'アップロード'
      find('.register-step-next-button').click
      fill_in('password', with: '')
      fill_in('password_confirmation', with: 'password')
      find('.register-step-next-button').click
    end
    
    it "（共通）ユーザー登録に失敗する" do
      find('.register-btn').click
      expect(current_path).to eq "/register"
      assert_text 'ユーザー登録に失敗しました'
    end
    
  end
end
