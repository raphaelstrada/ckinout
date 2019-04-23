require 'rails_helper'

RSpec.describe 'Employees API', type: :request do
    let!(:role) { create(:role) }
    let!(:school) { create(:school) }

    let!(:employees) { create_list(:employee, 20, school_id: school.id, role_id: role.id) }

    let(:school_id) { school.id }
    let(:role_id) { role.id }
    
    let(:id) { employees.first.id }

    # Test suite for GET /schools/:school_id/employees
    describe 'GET /schools/:school_id/employees' do
        before { get "/schools/#{school_id}/employees" }
    
        context 'when school exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns all school employees' do
                expect(json.size).to eq(20)
            end
        end
    
        context 'when school does not exist' do
            let(:school_id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find School/)
            end
        end
    end
    

    # Test suite for GET /schools/:school_id/employees/:id
    describe 'GET /schools/:school_id/employees/:id' do
        before { get "/schools/#{school_id}/employees/#{id}" }

        context 'when school employee exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the employee' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when school employee does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Employee/)
            end
        end
    end

    # Test suite for PUT /schools/:school_id/employees
    describe 'POST /schools/:school_id/employees' do
        let(:valid_attributes) { { 
            name: Faker::Movies::StarWars.character,
            uid: Faker::Number.number(4),
            password: "1234",
            role_id: role_id
            } }

        # context 'when request attributes are valid' do
        #     before { post "/schools/#{school_id}/employees", params: valid_attributes }

        #     it 'returns status code 201' do
        #         expect(response).to have_http_status(201)
        #     end
        # end

        context 'when an invalid request' do
            before { post "/schools/#{school_id}/employees", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Password can't be blank, Role must exist, Name can't be blank/)
            end
        end
    end

    # # Test suite for PUT /schools/:school_id/employees/:id
    # describe 'PUT /schools/:school_id/employees/:id' do
    # let(:valid_attributes) { { name: 'Mozart' } }

    # before { put "/schools/#{school_id}/employees/#{id}", params: valid_attributes }

    # context 'when employee exists' do
    #     it 'returns status code 204' do
    #     expect(response).to have_http_status(204)
    #     end

    #     it 'updates the employee' do
    #     updated_employee = employee.find(id)
    #     expect(updated_employee.name).to match(/Mozart/)
    #     end
    # end

    # context 'when the employee does not exist' do
    #     let(:id) { 0 }

    #     it 'returns status code 404' do
    #     expect(response).to have_http_status(404)
    #     end

    #     it 'returns a not found message' do
    #     expect(response.body).to match(/Couldn't find Employee/)
    #     end
    # end
    # end

    # # Test suite for DELETE /schools/:id
    # describe 'DELETE /schools/:id' do
    # before { delete "/schools/#{school_id}/employees/#{id}" }

    # it 'returns status code 204' do
    #     expect(response).to have_http_status(204)
    # end
    # end
    # end
    
  
end