require 'spec_helper'

module Specs

  class Person < ::Neo4j::Model
    property :name, :default => 'x'
    index :name
    has_n :friends
  end

  describe Neo4j::WillPaginate::Pagination do
    subject { source.paginate(:page => 2, :per_page => 3) }

    context ::Neo4j::Traversal::Traverser do
      let(:source)  { Person.all }
      before        { 10.times { Person.create } }

      its(:size)          { should == 3 }
      its(:current_page)  { should == 2 }
      its(:per_page)      { should == 3 }
      its(:total_entries) { should == 10 }
      its(:offset)        { should == 3 }
    end

    context ::Neo4j::Index::LuceneQuery do
      let(:source)  { Person.all(:conditions => 'name: *') }
      before        { 10.times { Person.create(:name => 'x') } }

      its(:size)          { should == 3 }
      its(:current_page)  { should == 2 }
      its(:per_page)      { should == 3 }
      its(:total_entries) { should == 10 }
      its(:offset)        { should == 3 }
    end

    context ::Neo4j::HasN::Mapping do
    end

    context ::Neo4j::HasList::Mapping do
    end

    context ::Neo4j::Rails::Relationships::NodesDSL do
      # class
    end

    context ::Neo4j::Rails::Relationships::RelsDSL do
      # class
    end
  end

end