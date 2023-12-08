require 'aws-sdk-s3'
class UploadedFilesController < ApplicationController
    
    def create_presigned_url
        s3 = Aws::S3::Resource.new(region: 'us-east-1')
        
        file_name = params[:file_name] || SecureRandom.uuid

        blob = ActiveStorage::Blob.create(filename: file_name)

        obj = s3.bucket('analogcapstonefiles').object(blob.key)
        url = obj.presigned_url(:put)

        render json: { presigned_url: url, file_name: file_name }, status: 200
    end

    def upload_complete
        file_name = params[:file_name]
  
        render json: { status: "File uploaded successfully", file_name: file_name }, status: 201
    end
end