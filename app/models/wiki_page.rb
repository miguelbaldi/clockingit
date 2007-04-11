class WikiPage < ActiveRecord::Base
  has_many :revisions, :class_name => 'WikiRevision', :order => 'id'
  has_one  :current_revision, :class_name => 'WikiRevision', :order => 'id DESC'
  belongs_to :company

  LOCKING_PERIOD = 30.minutes

  def lock(time, locked_by)
    update_attributes(:locked_at => time, :locked_by => locked_by)
  end

  def lock_duration(time)
    ((time - locked_at) / 60).to_i unless locked_at.nil?
  end

  def unlock
    update_attributes(:locked_at => nil, :locked_by => nil)
  end

  def locked?
    locked_at + LOCKING_PERIOD > Time.now.utc unless locked_at.nil?
  end

  def locked_by
    User.find( self.attributes['locked_by'] ) unless self.attributes['locked_by'].nil?
  end

  def to_html
    current_revision.to_html
  end

end