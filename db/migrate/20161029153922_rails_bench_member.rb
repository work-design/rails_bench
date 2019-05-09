class RailsBenchInit < ActiveRecord::Migration[5.0]
  def change
    
    create_table :pipelines do |t|
      t.references :organ
      t.references :piping, polymorphic: true
      t.string :name
      t.string :description
      t.timestamps
    end
    
    create_table :pipeline_members do |t|
      t.references :pipeline
      t.references :job_title
      t.references :member
      t.string :name
      t.integer :position
      t.timestamps
    end
    
    create_table :teams do |t|
      t.references :organ
      t.references :teaming, polymorphic: true
      t.string :name
      t.string :description
      t.timestamps
    end
    
    create_table :team_members do |t|
      t.references :team
      t.references :job_title
      t.references :member
      t.timestamps
    end
    
    create_table :projects do |t|
      t.references :creator
      t.string :name
      t.string :description
      t.string :github_repo
      t.timestamps
    end
    
    create_table :project_members do |t|
      t.references :project
      t.references :job_title
      t.references :member
      t.timestamps
    end
    
    
  end
end
