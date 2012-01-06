require 'spec_helper'

describe Mailer do
  describe 'email with multiple recipients' do
    it 'set correct recipients in X-SMTAPI header' do
      Mailer.email_with_multiple_recipients(%w(em1@email.com em2@email.com)).deliver.header.to_s.
        should include('X-SMTPAPI: {"to":["em1@email.com","em2@email.com"]}')
    end
  end

  describe '#open_tracking' do
    it 'set correct open tracking enabled X-SMTAPI header' do
      Mailer.email_open_tracking.deliver.header.to_s.
        should include('"filters":{"opentrack":{"settings":{"enabled":1}}}')
    end

    it 'set correct open tracking disabled X-SMTAPI header' do
      Mailer.email_open_tracking(false).deliver.header.to_s.
        should include('"filters":{"opentrack":{"settings":{"enabled":0}}}')
    end

    it 'set correct open tracking nil X-SMTAPI header' do
      Mailer.email_open_tracking(nil).deliver.header.to_s.
        should_not include('"filters":{"opentrack')
    end
  end
end
