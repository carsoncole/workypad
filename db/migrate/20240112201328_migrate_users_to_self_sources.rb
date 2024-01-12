class MigrateUsersToSelfSources < ActiveRecord::Migration[7.1]
  def up
    return if Source.all.count > 15
    User.all.each do |u|
      Source::SOURCES.each do |source_name|
        u.sources.create(name: source_name)
      end

      u.jobs.each do |j|
        new_source = u.sources.where(name: j.source&.name).first
        j.update(source_id: new_source.id) if new_source
      end
    end
  end
end
