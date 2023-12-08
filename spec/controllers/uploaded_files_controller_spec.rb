require "rails_helper"

RSpec.describe UploadedFilesController, type: :controller do
    describe "PUT #create_presigned_url" do
        it "returns http success" do
            post :create_presigned_url, params: { file_name: 'test_file_name' }
            expect(response).to have_http_status(:success)
        end

        it "returns presigned url" do
            post :create_presigned_url, params: { file_name: 'test_file_name' }

            expect(response).to have_http_status(:success)
            json_response = JSON.parse(response.body)
            # binding.pry
            expect(json_response['presigned_url']).to include('https://analogfiles.s3.amazonaws.com')
        end
    end
end