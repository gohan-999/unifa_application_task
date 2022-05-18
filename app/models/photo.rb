class Photo < ApplicationRecord
  class PhotoWriteError < StandardError; end

  attribute :updated_file

  validates :title, presence: { message: 'を入力してください' }, length: { maximum: 30, too_long: 'は%{count}文字以内にしてください' }
  validates :updated_file, presence: { message: 'を入力してください' }

  validate :image_type?

  def initialize(attributes = {})
    super(attributes)
    self.name = build_photo_name
  end

  def save_photo!
    return raise PhotoWriteError.new, '画像保存に必要な情報が足りません' if name.blank? || updated_file.blank?
    File.open(Rails.root.join('public', 'uploaded_photos') + name, 'w+b') do |f|
      f.write updated_file.read
    end
  end

  private

  def build_photo_name
    return '' if updated_file.blank?
    "#{Time.current.to_i.to_s}.#{updated_file.original_filename.split('.').last}"
  end

  def image_type?
    return false if updated_file.blank?
    ['jpeg', 'png', 'gif'].any? {|v| updated_file.content_type.include?(v) }
  end
end