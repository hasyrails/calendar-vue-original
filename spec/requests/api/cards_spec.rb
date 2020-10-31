require 'rails_helper'

RSpec.describe "Api::Cards", type: :request do
  describe "GET /api/cards" do
    subject { get(api_cards_path) }
    before { create(:card) }

    it "card一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 1
      expect(res[0].keys).to eq [
        "id",
        "body",
        "description",
        "start",
        "end",
        "color",
        "schedulized",
        "deadlined",
        "done",
        "list_id",
        "user_id",
        "done_at"
      ]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/cards" do
    subject { post(api_cards_path, params: params) }
    let(:params) {
      {
        "id": 1,
        "body": "TestCard",
        "description": "TestCardDetail",
        "user_id": 1,
        "list_id": 1,
      } 
    }
    
    it "cardレコードが作成される" do
      expect { subject }.to change { Card.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "PATCH /api/cards/:id" do
    subject { patch(api_card_path(card.id), params: params) }
    let(:card) { create(:card) }
    let(:params) {
      {
        "body": "UpdatedTestCardDetail",
      }
    }

      it "指定したcardレコードが更新される" do
        expect { subject }.to change { Card.find(card.id).body }.from(card.body).to(params[:body])
        expect { subject }.not_to change { Card.find(card.id).description }
        expect { subject }.not_to change { Card.find(card.id).created_at }
        res = JSON.parse(response.body)
        expect(res["body"]).to eq 'UpdatedTestCardDetail'
        expect(response).to have_http_status(200)
      end
    end

  describe "DELETE /api/cards/:id" do
    subject { delete(api_card_path(card.id)) }
    let!(:card) { create(:card) }

    it "指定したcardレコードが削除される" do
      expect { subject }.to change { Card.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
