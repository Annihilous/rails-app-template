require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  context 'given an admin User' do
    before(:each) do
      sign_in create(:user, is_admin: true)
    end

    describe 'GET #index' do
      it 'assigns all characters as @characters' do
        create_list(:character, 3)

        expected_ids = Character.all.pluck(:id)

        get :index

        expect(assigns(:characters).pluck(:id)).to match_array(expected_ids)
      end

      it 'filters Characters by name if params[:q] is set' do
        character_1 = create(:character, name: 'foo'   )
        character_2 = create(:character, name: 'bar'   )
        character_3 = create(:character, name: 'foobar')

        get :index, params: { q: 'foo' }

        expect(assigns(:characters)).to     include(character_1)
        expect(assigns(:characters)).to     include(character_3)
        expect(assigns(:characters)).not_to include(character_2)
      end
    end

    describe 'GET #show' do
      it 'assigns the requested character as @character' do
        character = create(:character)

        get :show, params: { id: character.to_param }

        expect(assigns(:character)).to eq(character)
      end
    end

    describe 'GET #new' do
      it 'assigns a new character as @character' do
        get :new

        expect(assigns(:character)).to be_a_new(Character)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested character as @character' do
        character = create(:character)

        get :edit, params: { id: character.to_param }

        expect(assigns(:character)).to eq(character)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        before(:each) do
          @params = build(:character).attributes
        end

        it 'creates a new Character' do
          expect {
            post :create, params: { character: @params }
          }.to change(Character, :count).by(1)
        end

        it 'assigns a newly created character as @character' do
          post :create, params: { character: @params }

          expect(assigns(:character)).to be_a(Character)

          expect(assigns(:character)).to be_persisted
        end

        it 'redirects to the created character' do
          post :create, params: { character: @params }

          expect(response).to redirect_to(Character.last)
        end
      end

      context 'with invalid params' do
        before(:each) do
          @params = build(:character, name: nil).attributes
        end

        it 'assigns a newly created but unsaved character as @character' do
          post :create, params: { character: @params }

          expect(assigns(:character)).to be_a_new(Character)
        end

        it 're-renders the "new" template' do
          post :create, params: { character: @params }

          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        before(:each) do
          @character = create(:character)
        end

        it 'updates the requested Character with a new name' do
          new_name = 'Nihil'

          put :update, params: { id: @character.to_param, character: {name: new_name} }

          @character.reload
          expect(@character.name).to eq(new_name)
        end

        it 'updates the requested Character with a new description' do
          new_description = 'Lorem ipsum dolor sit amet, ius in putant alterum sadipscing, ea utroque commune cum. Possit definitiones id eam. At facete gloriatur pro, congue iriure te sit, dolor fabellas inimicus te cum. Vide veri zril ut vim, id elitr voluptua vix, etiam munere doming ne vix. Mel te facilis senserit, ut mel exerci aliquam. Ex nisl atqui pro, mei error delenit periculis et. Prima viris elaboraret eu vix, at has quas apeirian honestatis, ei cum adhuc accusamus. Mea in erant dolor complectitur, ut debet fabulas vituperatoribus quo, wisi commodo ex nam. Idque graeco delicata cum ea, ex equidem tibique periculis vis, sint dolor ex pro. Brute integre bonorum sit ex, ea mei sale tincidunt.'

          put :update, params: { id: @character.to_param, character: {description: new_description} }

          @character.reload
          expect(@character.description).to eq(new_description)
        end

        it 'assigns the requested character as @character' do
          put :update, params: { id: @character.to_param, character: @character.attributes }

          expect(assigns(:character)).to eq(@character)
        end

        it 'redirects to the character' do
          put :update, params: { id: @character.to_param, character: @character.attributes }

          expect(response).to redirect_to(@character)
        end
      end

      context 'with invalid params' do
        before(:each) do
          @character =   create(:character)
          @new_name  =   nil
          @params    = { name: @new_name }
        end

        it 'assigns the character as @character' do
          put :update, params: { id: @character.to_param, character: @params }

          expect(assigns(:character)).to eq(@character)
        end

        it 're-renders the "edit" template' do
          put :update, params: { id: @character.to_param, character: @params }

          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      before(:each) do
        @character = create(:character)
      end

      it 'destroys the requested character' do
        expect {
          delete :destroy, params: { id: @character.to_param }
        }.to change(Character, :count).by(-1)
      end

      it 'redirects to the characters list' do
        delete :destroy, params: { id: @character.to_param }

        expect(response).to redirect_to(characters_url)
      end
    end
  end
end
