shared_context :stub_api_following_standards do
  let(:response) do
    {
        'data' => [ data ].flatten,
        'page' => 1,
        'page_size' => 1,
        'total' => 1
    }
  end
  let(:error_response) do
    {
        'errors' => [ data ].flatten,
        'page' => -1,
        'page_size' => 0,
        'total' => 0
    }
  end
  let(:headers) do
    {
        'Accept'=>'application/json',
        'Accept-Encoding'=>'deflate, gzip',
        'Authorization'=>'Bearer token',
        'Content-Type' => 'application/json',
        'Developerkey'=> Cb.configuration.dev_key
    }
  end

  def expect_api_to_error(error, stub)
    expect(stub).to have_been_requested
    expect(error.response.class).to eq(Hash)
    expect(error.response['errors'].class).to eq(Array)
    expect(error.response['errors'].length).to eq(1)
    expect(error.response['errors'][0]).to eq(data)
  end

  def expect_api_to_succeed_and_return_model(response, stub)
    expect(stub).to have_been_requested
    expect(response.class).to eq(Hash)
    expect(response['data'].class).to eq(Array)
    expect(response['data'][0]).to eq(data)
    expect(response['data'].count).to eq(1)
  end
end
