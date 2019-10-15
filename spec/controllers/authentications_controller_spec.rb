# frozen_string_literal: true

require 'spec_helper'

describe AuthenticationsController do
  describe '#login' do
    subject { post :login, params: params }

    let(:provider) { 'identity' }
    let(:params) { { provider: provider } }
    let(:login) { create :login, user: current_user }
    let(:auth_params) do
      OpenStruct.new(
        provider: provider,
        uid: login.uid
      )
    end

    before do
      request.env['omniauth.auth'] = auth_params
    end

    it 'flashes warning if user not found' do
      expect(subject.request.flash[:error]).to_not be_nil
    end

    context 'with confirmed user' do
      let(:login) { create :login, :confirmed, user: current_user }

      it { is_expected.to redirect_to %r{\/#\!home} }
    end
  end
end
