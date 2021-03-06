require 'spec_helper'

describe ContactsController do

  describe 'GET #index' do
    context 'with params[:letter]' do
      it "populates an array of contacts starting with the letter"
      it "renders the :index view"
    end

    context 'without params[:letter]' do
      it "populates an array of all contacts"
      it "render the :index view"
    end
  end

  describe 'GET #show' do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :show, id: contact
      expect(assigns(:contact)).to eq contact
    end
    it "renders the :show template" do
      contact = create(:contact)
      get :show, id:contact
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Contact to @contact"
    it "renders the :new template"
  end

  describe 'GET #edit' do
    it "assigns the requested contact to @contact"
    it "renders the :edit template"
  end

  describe 'POST #create' do
    before :each do
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),
        attributes_for(:phone)
      ]
    end
    context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{
          post :create, contact: attributes_for(:contact,
                                               phones_attributes: @phones)
        }.to change(Contact, :count).by(1)
      end
      it "redirects to contacts#show" do
        post :create, contact: attributes_for(:contact,
                                             phones_attributes: @phones)
        expect(response).to redirect_to contact_path(assigns(:contact))
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post :create,
            contact: attributes_for(:invalid_contact)
        }.to_not change(Contact, :count)
      end
      it "re-renders the :new template"
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" do
      it "updates the contact in database"
      it "redirects to the contact"
    end

    context "with invalid attributes" do
      it "does not update the contact"
      it "re renders the #edit template"
    end
  end

  describe 'DELETE #destroy' do
    it "deletes the contact from the database"
    it "redirects to users#index"
  end
end
