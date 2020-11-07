require 'rails_helper'

RSpec.describe 'Users', type: :request do

  let!(:user) {create(:user)}

  def auth_headers
    post '/api/v1/auth/sign_in', params: {email:user['email'], password: 'password'}
    { 'uid'=>response.header['uid'], 'client'=>response.header['client'], 'access-token'=>response.header['access-token'] }
  end

  describe 'GET api/whoami' do
    context '未ログインの場合' do
      fit 'HTTPステータスが401であること' do
        get '/api/whoami'
        expect(response.status).to eq(401)
      end
    end
    context 'ログインずみの場合' do
      before do
        get '/api/whoami', headers: auth_headers
      end
      fit 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end
      fit 'レスポンスが正しいこと' do
        expect(JSON.parse(response.body)['id']).to eq(user['id'])
      end
    end
  end
end
