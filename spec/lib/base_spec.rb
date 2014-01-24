# encoding: utf-8
require 'spec_helper'

describe RecordCache::Base do

  it "should run a block in enabled mode" do
    RecordCache::Base.disable!
    RecordCache::Base.enabled do
      RecordCache::Base.status.should == RecordCache::ENABLED
    end
    RecordCache::Base.status.should == RecordCache::DISABLED
  end

  it "should use the record_cache from parent class when caching subclasses" do
    dog = Dog.create!(:name => "Puppy")

    lambda { Dog.find 1 }.should hit_cache(Animal).on(:id).times(1)
  end

  it "should not raise an exception if class or ancestors does not have record_cache" do
    object = Uncacheable.create!
    lambda { Uncacheable.find 1 }.should_not raise_error
  end

end
