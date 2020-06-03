class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  # accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }


  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    self.try(:genre).try(:name)
  end    

  def artist_name
    self.try(:artist).try(:name)
  end
  
  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def note_contents
    self.notes.collect(&:content)
  end

  def note_contents=(note_contents)
    note_contents.each do |content|
      unless content.empty?
        self.notes << Note.create(content: content)
        self.save
      end
    end
  end

end


