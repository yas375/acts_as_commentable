module ActsAsCommentable
  module ActiveRecord

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_commentable
        has_many :comments, :as => :commentable, :dependent => :destroy
      end
    end
  end
end
