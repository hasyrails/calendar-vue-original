require 'rails_helper'

RSpec.describe 'Auth', type: :request do

  let!(:user) {create(:user)}

  describe 'POST /api/v1/auth' do
    context '正常' do
      let(:params) {{email:'test@example.com', password:'password'}}
      before do
        post '/api/v1/auth', params: params
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'レスポンスが正しいこと' do
        expect(JSON.parse(response.body)['status']).to eq("success")
      end
    end
  end

  describe 'POST /api/auth/v1/sign_in' do
    context '正常' do
      before do
        post '/api/v1/auth/sign_in', params: {email:user['email'], password: 'password'}
      end

      it 'HTTPステータスが200であること' do
        expect(response.status).to eq(200)
      end

      it 'レスポンスが正しいこと' do
        json = JSON.parse(response.body)
        expect(json['data']['email']).to eq(user['email'])
      end
    end

    context '異常' do
      before do
        post '/api/v1/auth/sign_in', params: {email:user['email'], password: 'passwordxxx'}
      end

      it 'HTTPステータスが401であること' do
        expect(response.status).to eq(401)
      end

      it 'レスポンスが正しいこと' do
        json = JSON.parse(response.body)
        expect(json['success']).to eq(false)
      end
    end
  end

end
