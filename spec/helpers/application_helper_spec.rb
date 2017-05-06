require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  let(:user) { 'foo' }
  let(:dialect) { 'yoda' }

  describe "#logged" do
    context "when user is logged" do
      before { set_session_user }
      it { expect(helper.logged?). to eq true}
    end

    context "when user is not logged" do
      it { expect(helper.logged?). to eq false }
    end
  end

  describe "#home_partial" do
    context "when user is logged" do
      before { set_session_user }
      it { expect(helper.home_partial). to eq 'user' }
    end

    context "when user is not logged" do
      it { expect(helper.home_partial). to eq 'visitor' }
    end
  end


  describe "#username" do
    before { set_session_user }
    it { expect(helper.username). to eq username}
  end

  def set_session_user
    session  = helper.controller.session
    session[:username] = user
    session[:dialect] = dialect
  end
end

