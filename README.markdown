= ActsAsCommentable

With this plugin you can simply implement counter of page views.

== Dependencies

awesone_nested_set

== Setup

Install plugin:

    ./script/plugin install git://github.com/yas375/acts_as_commentable.git

or you can add this plugin as submodule:

    git submodule add git://github.com/yas375/acts_as_commentable.git vendor/plugins/acts_as_commentable

Add to your config/environment.rb:

    config.gem 'awesome_nested_set'

Create new migration file and insert to it:

    class CreateComments < ActiveRecord::Migration
      def self.up
        create_table :comments do |t|
          t.integer :commentable_id
          t.string  :commentable_type
          t.text    :text
          t.integer :author_id
          t.integer :parent_id
          t.integer :lft
          t.integer :rgt

          t.timestamps
        end
      end

      def self.down
        drop_table :comments
      end
    end

Run migration and after that make content of app/models/comment.rb like below:

    class Comment < ActiveRecord::Base
      attr_accessible :text, :parent_id, :author, :commentable

      belongs_to :commentable, :polymorphic => true
      acts_as_nested_set :scope => [:commentable_id, :commentable_type]

      belongs_to :author, :class_name => 'User'

      validates_presence_of :text, :author, :commentable
    end

== Usage

Once you have installed the plugin you can start using it in your ActiveRecord models simply by calling the acts_as_commentable method.

    class Post < ActiveRecord::Base
      acts_as_commentable
    end

Access all comments for post:

    Post.first.comments

You can manipulate with comments as with usual awesome nested set. See documentation for awesome_nester_set for details.

Copyright (c) 2010 Ilyukevich Victor, released under the MIT license