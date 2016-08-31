require 'rails_helper'

describe 'Index' do
  let!(:post) { FactoryGirl.create(:post) }

  it 'should be success' do
    get '/api/posts', as: :json
    expect(response).to be_success
  end

  it 'the post attributes are the same' do
    get '/api/posts', as: :json
    json = JSON.parse(response.body)
    expect(json.first['title']).to eq(post.title)
  end
end

describe 'Create' do
  post_params = {
    'post': {
      'title': 'Hot news',
      'body': 'Invasion',
      'username': 'Kenny'
    }
  }

  it 'should be success' do
    post '/api/posts', params: post_params, as: :json
    expect(response).to be_success
  end

  it 'should be "Hot news"' do
    post '/api/posts', params: post_params, as: :json
    expect(Post.first.title).to eq 'Hot news'
  end
end

describe 'Update' do
  let!(:post) { FactoryGirl.create(:post) }
  post_params = {
    'post': {
      'title': 'Cold news'
    }
  }

  it 'should be success' do
    put "/api/posts/#{post.id}", params: post_params, as: :json
    expect(response).to be_success
  end

  it 'should be "Cold news"' do
    put "/api/posts/#{post.id}", params: post_params, as: :json
    expect(Post.first.title).to eq 'Cold news'
  end
end

describe 'Delete' do
  let!(:post) { FactoryGirl.create(:post) }

  it 'should be success' do
    delete "/api/posts/#{post.id}", as: :json
    expect(response).to be_success
  end

  it "shouldn't any records"  do
    delete "/api/posts/#{post.id}", as: :json
    expect(Post.count).to eq 0
  end
end
