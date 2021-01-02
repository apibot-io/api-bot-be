class Api::V0::MocksController < ApplicationController
  # This is the one and only action mapped to each mock route
  def serve_mock
    mock = Mock.find(params[:mock_id])

    render body: mock.body_content,
           content_type: mock.content_type,
           status: status
  end
end
