# frozen_string_literal: true

# create user class
class User
  attr_accessor :id, :name, :avatar, :sex, :active, :created_at

  def initialize(user)
    @id = user[:id]
    @name = user[:name]
    @avatar = user[:avatar]
    @sex = user[:sex]
    @active = user[:active]
    @created_at = user[:created_at]
  end

  def to_string
    "ID: #{@id}\nName: #{@name}\nAvatar: #{@avatar}\nSex: #{@sex}\nActive: #{@active}\nCreated At: #{@created_at}\n"
  end

  def to_arr
    [@id, @name, @avatar, @sex, @active, @created_at]
  end

  def as_json(_options = {})
    {
      id: @id,
      name: @name,
      avatar: @avatar,
      sex: @sex,
      active: @active,
      created_at: @created_at
    }
  end

  def change_to_json(*options)
    as_json(*options).to_json(*options)
  end
end
