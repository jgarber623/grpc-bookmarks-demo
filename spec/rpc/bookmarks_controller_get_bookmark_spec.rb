describe BookmarksController, '#get_bookmark' do
  subject(:response) { run_rpc(:GetBookmark, request) }

  context 'when Bookmark does not exist' do
    let(:request) { Rpc::GetBookmarkRequest.new(id: 100) }

    it 'returns an error' do
      expect { response }.to raise_rpc_error(GRPC::NotFound)
    end
  end

  context 'when Bookmark exists' do
    let(:bookmark) { create(:bookmark) }
    let(:request) { Rpc::GetBookmarkRequest.new(id: bookmark.id) }

    it 'returns a Bookmark' do
      expect(response).to be_a(Rpc::Bookmark)
      expect(response.id).to eq(bookmark.id)
    end
  end
end
