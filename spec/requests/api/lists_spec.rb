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

  # Listの更新アクション未実装→要実装
    # describe "PATCH /api/v1/todos/:id" do
    #   subject { patch(api_v1_todo_path(todo.id), params: params) }
    #   let(:todo) { create(:todo) }
    #   let(:params) { { todo: { done: true, created_at: Time.current } } }

    #   it "指定したレコードが更新される" do
    #     expect { subject }.to change { Todo.find(todo.id).done }.from(todo.done).to(params[:todo][:done])
    #     expect { subject }.not_to change { Todo.find(todo.id).body }
    #     expect { subject }.not_to change { Todo.find(todo.id).created_at }
    #     expect(response).to have_http_status(204)
    #   end
    # end

  describe "DELETE /api/lists/:id" do
    subject { delete(api_list_path(list.id)) }
    let!(:list) { create(:list) }

    it "指定したレコードが削除される" do
      expect { subject }.to change { List.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
