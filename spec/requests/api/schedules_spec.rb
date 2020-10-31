require 'rails_helper'

RSpec.describe "Api::Schedules", type: :request do
  describe "GET /api/schedules" do
    subject { get(api_schedules_path) }
    before { create(:schedule) }

    it "schedule一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 1
      expect(res[0].keys).to eq [
        "id",
        "body",
        "description",
        "start",
        "deadline",
        "done",
        "deadlined",
        "date",
        "date_year",
        "date_month",
        "date_day",
        "commit",
        "color",
        "card_id",
        "user_id",
        "done_at",
      ]
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST /api/schedules" do
    subject { post(api_schedules_path, params: params) }
    today = Date.today.strftime('%Y-%m-%d')
    tomorrow = Date.tomorrow.strftime('%Y-%m-%d')
    let(:params) {
      {
        "id": 1,
        "body": 'TestSchedule',
        "description": 'TestScheduleDetail',
        "start": today,
        "deadline": tomorrow,
        "done": false,
        "deadlined": '',
        "date": '',
        "date_year": '',
        "date_month": '',
        "date_day": '',
        "commit": true,
        "color": '',
        "card_id": 1,
        "user_id": 1,
        "done_at": '',
      }
    }
    
    it "scheduleレコードが作成される" do
      expect { subject }.to change { Schedule.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "PATCH /api/schedules/:id" do
    subject { patch(api_schedule_path(schedule.id), params: params) }
    let(:schedule) { create(:schedule) }
    let(:params) {
      {
        "body": "UpdatedTestCardDetail",
      }
    }

      it "指定したscheduleレコードが更新される" do
        expect { subject }.to change { Schedule.find(schedule.id).body }.from(schedule.body).to(params[:body])
        expect { subject }.not_to change { Schedule.find(schedule.id).description }
        expect { subject }.not_to change { Schedule.find(schedule.id).created_at }
        res = JSON.parse(response.body)
        expect(res["body"]).to eq 'UpdatedTestCardDetail'
        expect(response).to have_http_status(200)
      end
    end

  describe "DELETE /api/schedules/:id" do
    subject { delete(api_schedule_path(schedule.id)) }
    let!(:schedule) { create(:schedule) }

    it "指定したscheduleレコードが削除される" do
      expect { subject }.to change { Schedule.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
