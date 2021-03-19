class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  accepts_nested_attributes_for :notes

  def artist_name=(name)
    artist = Artist.find_or_create_by name: name
    artist.songs << self
  end

  def artist_name 
    self.artist ? self.artist.name : nil
  end

  def artist_attributes=(artist)
    self.artist = Artist.find_or_create_by(name: artist[:name])
    self.artist.update(artist)
  end

  def genre_attributes=(genre)
    self.genre = Genre.find_or_create_by(name: genre[:name])
    self.genre.update(genre)
  end

  def note_contents=(notes)
    (notes-[""]).each do |content|
      self.notes.new.content=content
    end
 end
end
