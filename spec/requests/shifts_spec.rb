require 'rails_helper'

RSpec.describe 'Shifts API', type: :request do
    let!(:school) { create(:school) }
    let!(:role) { create(:role) }

    let(:school_id) { school.id }
    let(:roleid) { role.id }

    let!(:employee) { create(:employee, school_id: school.id, role_id: role.id) }
    let(:employee_id) { employee.id }
    
    let!(:shifts) { create_list(:shift, 20, employee_id: employee.id) }
    let(:id) { shifts.first.id }

    describe 'GET /schools/:school_id/employees/:employee_id/shifts' do
        before { get "/schools/#{school_id}/employees/#{employee_id}/shifts" }
    
        context 'when employee exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns all employees shifts' do
                expect(json.size).to eq(20)
            end
        end
    
        context 'when employee does not exist' do
            let(:employee_id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Employee/)
            end
        end
    end



     # Test suite for GET /schools/:school_id/shifts/:id
     describe 'GET /schools/:school_id/employees/:employee_id/shifts/:id' do
        before { get "/schools/#{school_id}/employees/#{employee_id}/shifts/#{id}" }

        context 'when employee shift exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the shift' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when employee shift does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Shift/)
            end
        end
    end

    # Test suite for PUT 
    describe 'POST /schools/:school_id/employees/:employee_id/shifts' do
        let(:valid_attributes) { { 

            worked_from: Faker::Time.between(Date.today, Date.today, :day),
            worked_to: Faker::Time.between(Date.today, Date.today, :night),
            business_day: Date.today,
            snapshot_from: "",
            snapshot_to: "",
            employee_id: employee_id

            } }

        # context 'when request attributes are valid' do
        #     before { post "/schools/#{school_id}/employees", params: valid_attributes }

        #     it 'returns status code 201' do
        #         expect(response).to have_http_status(201)
        #     end
        # end

        context 'when an invalid request' do
            before { post "/schools/#{school_id}/employees/#{employee_id}/shifts", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Worked from can't be blank/)
            end
        end
    end


end