module AlbumsHelper
  def get_access_types
    [
        ['public', 0],
        ['private', 1],
        ['friends', 2],
        ['mature content', 3]
    ]
  end

end
