FactoryBot.define do
  factory :bookmark do
    bookmarked_url { 'https://www.bugsnag.com/blog/grpc-and-microservices-architecture' }
    canonical_url { 'https://www.bugsnag.com/blog/grpc-and-microservices-architecture' }
    archive_org_snapshot_url { 'http://web.archive.org/web/20190511120934/https://www.bugsnag.com/blog/grpc-and-microservices-architecture' }
    initial_http_status_code { '200 OK' }
    final_http_status_code { '200 OK' }
    note { nil }
  end
end
