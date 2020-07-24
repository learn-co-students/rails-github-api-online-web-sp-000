require_relative '../spec_helper'

describe 'authentication' do
  it 'displays the username on the page' do
    stub_request(:post, "https://github.com/login/oauth/access_token").
      with(
        body: {"client_id"=>ENV["CLIENT_ID"], "client_secret"=>ENV["CLIENT_SECRET"], "code"=>"20", "scope"=>"repo"},
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v0.15.4'
        }
      ).
      to_return(status: 200, body: "", headers: {})
  end
end

describe 'visiting root' do
  before :each do
    page.set_rack_session(token: '1')
  end

  it 'lists repos' do
    visit '/'
    expect(page).to have_content 'Repo 1'
    expect(page).to have_content 'Repo 2'
    expect(page).to have_content 'Repo 3'
  end
end
