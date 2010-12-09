module ActsAsCommentable
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      # base.class_eval do
      # end
    end

    module ClassMethods
      def acts_as_commentable
        has_many :comments, :as => :commentable, :dependent => :destroy
        after_create :create_root_comment
      end
    end

    module InstanceMethods
      # there should be an author method in your commentable model
      def create_root_comment
        Comment.create(:commentable => self, :text => 'root', :author => author)
      end
    end
  end
end
