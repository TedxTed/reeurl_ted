require "rails_helper"
require 'base64'
require 'digest/crc32'

RSpec.describe LinksController , type: :controller do
  login_user
  before(:each) do 
    new_link = create(:link , user_id: @user.id )

    @link_params ={
      orginurl:new_link.orginurl,
      user_id:new_link.user_id
    }

  end
      
      it "#index " do 
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end 

    describe "#create" do
      
      it "creates record" do 
        puts @user
          expect {
            post :create, params:{link: @link_params}
          }.to change(Link, :count).by(1) 
        
      end 
      it "shorturl為正確" do 
        link_after_create = Link.find_by(orginurl: @link_params[:orginurl])
        slug = Digest::CRC32.hexdigest("#{link_after_create.id}")

        expect(link_after_create.slug).to eql(slug)
      end
    end

    describe "#redirect_to_orginurl" do 
      before(:example) do 
        Link.create!(@link_params)
        @link_after_create = Link.find_by(orginurl: @link_params[:orginurl])
        @slug = @link_after_create.slug
      end

      it "執行後可以得到302 status" do 
        
        expect(response).to have_http_status(200)
      end

      it "到show時可以正確的比照到正確的長網址" do 
        get :redirect_to_orginurl, params:{slug: @slug }
        p @link_after_create
        expect(response).to redirect_to(Link.find_by(slug: @slug).orginurl) 
      end
    end
  
end

