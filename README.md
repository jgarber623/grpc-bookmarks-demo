# grpc-bookmarks-demo

**A [Ruby on Rails](https://rubyonrails.org) application demonstrating an API served using [gRPC](https://grpc.io) and [Protocol Buffers](https://developers.google.com/protocol-buffers).**

[![Build](https://img.shields.io/travis/com/jgarber623/grpc-bookmarks-demo/master.svg?style=for-the-badge)](https://travis-ci.com/jgarber623/grpc-bookmarks-demo)
[![Dependencies](https://img.shields.io/depfu/jgarber623/grpc-bookmarks-demo.svg?style=for-the-badge)](https://depfu.com/github/jgarber623/grpc-bookmarks-demo)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/jgarber623/grpc-bookmarks-demo.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/grpc-bookmarks-demo)
[![Coverage](https://img.shields.io/codeclimate/c/jgarber623/grpc-bookmarks-demo.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/grpc-bookmarks-demo/code)

## Getting Started

Before using grpc-bookmarks-demo, you'll want to have [Ruby](https://www.ruby-lang.org) 2.6.5 (or newer) installed. It's recommended that you use a Ruby version managment tool like [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), or [rvm](https://github.com/rvm/rvm).

You'll also want to install [SQLite](https://sqlite.org). If you're using macOS and Homebrew, run `brew install sqlite3`.

## Installation

```sh
# Clone this repository
git clone https://github.com/jgarber623/grpc-bookmarks-demo

# Navigate to the cloned directory
cd grpc-bookmarks-demo

# Install Ruby dependencies and prepare SQLite database
bin/setup

# Seed SQLite database
bin/rails db:seed
```

## Usage

This project uses the [gruf Ruby gem](https://rubygems.org/gems/gruf) to serve gRPC endpoints. gruf also provides a gRPC client that can be used to test served endpoints. You could use other languages and libraries to interact with the grpc-bookmarks-demo API, but for the purposes of this documentation, we'll use a gruf client.

First, start the server using `bin/gruf`. By default, grpc-bookmarks-demo starts a server on host `0.0.0.0` and port `9001`. These can be overriden using environment variables (`GRPC_SERVER_HOST` and `PORT`) or by passing a combined value via the command line (e.g. `bin/gruf --host 'localhost:5000'`).

In a seperate terminal tab, connect to the Rails console using `bin/rails console`. grpc-bookmarks-demo provides a single service, `Rpc::Bookmarks`, that provides two gRPC methods, `:ListBookmarks` and `GetBookmark`.

### Create a Client

```ruby
# Create a client
client = Gruf::Client.new(service: Rpc::Bookmarks, options: { hostname: '0.0.0.0:9001' })
```

### Retrieve a Bookmark

```ruby
# Retrieve a single bookmark by ID
response = client.call(:GetBookmark, id: 975)

# Interact with the response
message = response.message
# => <Rpc::Bookmark: id: 975, bookmarked_url: "…", …>

message.bookmarked_url
# => "https://matthiasott.com/articles/into-the-personal-website-verse"

message.final_http_status_code
# => "200 OK"
```

### Stream a list of Bookmarks

```ruby
# Retrieve a list of bookmarks
response = client.call(:ListBookmarks, limit: 5, offset: 950)

# Interact with the response
message = response.message
# => #<Enumerator: …>

# Iterate over streamed response messages
message.each { |bookmark| puts bookmark.bookmarked_url }
# => https://thoughtbot.com/upcase
# => https://m.signalvnoise.com/the-next-big-jump-in-basecamp-accessibility-a2119c08309e
# => https://makers.snips.ai/
# => https://designsystem.gov.au/
# => https://securitycheckli.st/
```

## Updating Protocol Buffers

```ruby
# Compile new Ruby classes from *.proto files
bin/rake protos:compile
```

## License

grpc-bookmarks-demo is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
