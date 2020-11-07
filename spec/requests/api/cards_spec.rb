require 'rails_helper'

RSpec.describe "Api::Cards", type: :request do
  describe "GET /api/cards" do
    subject { get(api_cards_path) }
    let(:card) { build(:card) }

    it "card一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 1
      expect(res[0].keys).to eq [
        "id",
        "body",
        "description",
        "start",
        "deadline",
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
        "id": card.id,
        "body": card.body,
        "description": card.description,
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
        expect(res[0]["card"]["body"]).to eq 'UpdatedTestCardDetail'
        expect(response).to have_http_status(200)
      end
    end

  describe "PATCH /api/cards/:id" do
    subject { patch(api_card_path(card.id), params: params) }
    let(:card) { create(:card) }
    let!(:schedule) { create(:schedule) }
    let(:params) {
      {
        "body": "UpdatedTestCardDetail",
      }
    }
    
    it "更新したcardレコードと紐づいたscheduleレコードが更新される" do
      expect { subject }.to change { Schedule.find(schedule.id).body }.from(schedule.body).to(params[:body])
      expect { subject }.not_to change { Schedule.find(schedule.id).description }
      expect { subject }.not_to change { Schedule.find(schedule.id).created_at }
      res = JSON.parse(response.body)
      expect(res[1]["schedules"][0]["body"]).to eq 'UpdatedTestCardDetail'
      expect(response).to have_http_status(200)
    end
  end
  
  describe "PATCH  /api/cards/:id/deadlined" do
    yesterday = Date.yesterday.strftime("%Y-%m-%d")
    today = Date.today.strftime("%Y-%m-%d")
    tomorrow = Date.tomorrow.strftime("%Y-%m-%d")
    
    let(:card) {
      create(:card, deadline: today) 
    }
    
    it "期限が過ぎたカードはdeadlined:true" do
      travel_to tomorrow do
        patch api_deadlined_path(card.id)
        res = JSON.parse(response.body)
        expect(res[0]["deadlined"]).to eq true
      end
    end
    
    it "期限が過ぎていないカードはdeadlined:false" do
      travel_to yesterday do
        patch api_deadlined_path(card.id)
        res = JSON.parse(response.body)
        expect(res[0]["deadlined"]).to eq false
      end
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
