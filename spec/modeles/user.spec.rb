require 'rails_helper'

RSpec.describe User, type: :model do
  context "ユーザーが正しく登録される" do
    before do
      @user = User.new
      @user.name = "太郎"
      @user.email = "aa@aa"
      @user.password = "11aabb"
      @user.encrypted_password = "11aabb"
      @user.save
    end
    it "全て入力してあるので保存される" do
      expect(@user).to be_valid
    end
  end
end