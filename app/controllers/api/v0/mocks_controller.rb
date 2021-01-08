class Api::V0::MocksController < Api::V0::ApiController
  def create
    @mock = Mock.new(mock_params)

    if @mock.save
      render json: @mock, status: :created
    else
      render json: @mock.errors, status: :unprocessable_entity
    end
  end

  # This is the one and only action mapped to each mock route
  def serve_mock
    mock = Mock.find(params[:mock_id])

    render body: mock.body_content,
           content_type: mock.content_type,
           status: status
  end

  private

  def mock_params
    params.permit(:status_code, :request_method, :content_type, :route_path, :name,
                  :body_content)
  end
end
