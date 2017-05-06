require "rails_helper"

RSpec.describe AuthenticationController, :type => :controller do
  let(:username) { 'me' }
  let(:dialect) { 'Yoda' }

  describe "POST #signin" do
    before { post :signin, params: { username: username, Dialect: dialect } }

    it { expect(controller.session[:username]).to eq username }
    it { expect(controller.session[:dialect]).to eq dialect }
    it { expect(response).to have_http_status(302) }
  end

  describe "DELETE #logout" do
    before do
      controller.session[:username] = username
      controller.session[:dialect] = dialect
      delete :logout
    end

    it { expect(controller.session[:username]).to be_nil }
    it { expect(controller.session[:dialect]).to be_nil }
    it { expect(response).to have_http_status(302) }
  end
end