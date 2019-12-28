describe BookmarksController, '#list_bookmarks' do
  subject(:response) { run_rpc(:ListBookmarks, request) }

  context 'when Bookmarks do not exist' do
    let(:request) { Rpc::ListBookmarksRequest.new }

    it 'returns an empty array' do
      expect(response).to be_a(Array)
      expect(response.length).to eq(0)
    end
  end
end
