require 'rails_helper'

RSpec.describe "Api::Lists", type: :request do
  describe "GET /api/lists" do
    subject { get(api_lists_path) }
    before { create_list(:list, 3) }

    it "List一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "title", "user_id"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/lists" do
    subject { post(api_lists_path, params: params) }
    let(:params) {
      {
        "id": 1,
        "title": "TestList",
        "user_id": 1
      } 
    }

    it "レコードが作成される" do
      expect { subject }.to change { List.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end
end
