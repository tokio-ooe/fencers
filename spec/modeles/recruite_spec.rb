require 'rails_helper'

RSpec.describe Recruit, type: :model do
  context "Recruitが正しく登録される" do
    before do
      @recruite = Recruit.new
      @recruite.title = "タイトル"
      @recruite.body = "詳細"
      @recruite.position = "場所"
      @recruite.reward = "報酬"
      @recruite.date = "2020/4/2"
      @recruite.save
    end
    it "全て入力してあるので保存される" do
      expect(@recruite).to be_valid
    end
  end
end