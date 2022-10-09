require 'rails_helper'
require 'base64'
require 'digest/crc32'

RSpec.describe LinksController, type: :controller do
  login_user
  before(:each) do
    new_link = create(:link, user_id: @user.id)

    @link_params = {
      orginurl: new_link.orginurl,
      user_id: new_link.user_id
    }
  end

  it '#index ' do
    get :index

    expect(assigns(:links)).to eq(@user.links)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  describe '#create' do
    context 'create成功的狀況' do
      it 'creates record' do
        expect do
          post :create, params: { link: @link_params }
        end.to change(Link, :count).by(1)
      end

      it 'shorturl為正確' do
        link_after_create = Link.find_by(orginurl: @link_params[:orginurl])
        slug = Digest::CRC32.hexdigest("#{link_after_create.id}")

        expect(link_after_create.slug).to eql(slug)
      end

      it 'redirect on success' do
        post :create, params: { link: @link_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'create 失敗的狀況' do
      it 'render :new on fail' do
        post :create, params: { link: {
          user_id: @user.id
        } }

        expect(response).to render_template(:new)

        allow_any_instance_of(Link).to receive(:save).and_return(false)
      end
    end
  end

  describe '#redirect_to_orginurl' do
    context 'redirect成功的狀況' do
      before(:example) do
        Link.create!(@link_params)
        @link_after_create = Link.find_by(orginurl: @link_params[:orginurl])
        @slug = @link_after_create.slug
      end

      it '執行後可以得到302 status' do
        get :redirect_to_orginurl, params: { slug: @slug }
        expect(response).to have_http_status(302)
        expect(response).not_to have_http_status(200)
      end

      it '到show時可以正確的轉址到正確的長網址' do
        get :redirect_to_orginurl, params: { slug: @slug }

        expect(response).to redirect_to(Link.find_by(slug: @slug).orginurl)
      end
    end

    context 'redirect失敗的狀況' do
      it '到show時非認識的slug要show 404' do
        get :redirect_to_orginurl, params: { slug: '0000' }

        expect(response).to have_http_status(404)

        expect(response.body).to match(/doesn't exist/)
      end
    end
  end
end
