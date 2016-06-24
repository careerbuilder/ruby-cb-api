shared_context :stub_api_following_standards do
  let(:response) do
    {
        'data' => data,
        'page' => 1,
        'page_size' => data.length,
        'total' => data.length
    }
  end
  let(:error_response) do
    {
        'errors' => data,
        'page' => -1,
        'page_size' => 0,
        'total' => 0
    }
  end
  let(:headers) do
    {
        'Accept'=>'application/json',
        'Accept-Encoding'=>'gzip,deflate',
        'Authorization'=>'Bearer token',
        'Content-Type' => 'application/json',
        'Developerkey'=> Cb.configuration.dev_key
    }
  end

  def expect_api_to_error(error, stub)
    expect(stub).to have_been_requested
    expect(error.response.class).to eq(Hash)
    expect(error.response['errors']).to eq(data)
  end

  def expect_api_to_succeed_and_return_model(response, stub)
    expect(stub).to have_been_requested
    expect(response.class).to eq(Hash)
    expect(response['data']).to eq(data)
  end
end
