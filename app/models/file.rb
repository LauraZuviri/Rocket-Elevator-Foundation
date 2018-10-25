class File < ApplicationRecord
    def read_chunk(chunk_size=2000)
      yield read(chunk_size) until eof?
    end
  end