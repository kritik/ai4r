# Author::    Sergio Fierens (implementation)
# License::   MPL 1.1
# Project::   ai4r
# Url::       http://ai4r.rubyforge.org/
#
# You can redistribute it and/or modify it under the terms of 
# the Mozilla Public License version 1.1  as published by the 
# Mozilla Foundation at http://www.mozilla.org/MPL/MPL-1.1.txt

require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/ai4r/clusterers/centroid_linkage'

class Ai4r::Clusterers::CentroidLinkage
  attr_accessor :data_set, :number_of_clusters, :clusters, :distance_matrix, :index_clusters
  public :linkage_distance
  public :create_initial_index_clusters
end

class Ai4r::Clusterers::CentroidLinkageTest < Test::Unit::TestCase
  
  include Ai4r::Clusterers
  include Ai4r::Data

  @@data = [  [10, 3], [3, 10], [2, 8], [2, 5], [3, 8], [10, 3],
              [1, 3], [8, 1], [2, 9], [2, 5], [3, 3], [9, 4]]
            
  @@expected_distance_matrix = [ 
        [98.0], 
        [89.0, 5.0], 
        [68.0, 26.0, 9.0], 
        [74.0, 4.0, 1.0, 10.0], 
        [0.0, 98.0, 89.0, 68.0, 74.0], 
        [81.0, 53.0, 26.0, 5.0, 29.0, 81.0], 
        [8.0, 106.0, 85.0, 52.0, 74.0, 8.0, 53.0], 
        [100.0, 2.0, 1.0, 16.0, 2.0, 100.0, 37.0, 100.0], 
        [68.0, 26.0, 9.0, 0.0, 10.0, 68.0, 5.0, 52.0, 16.0], 
        [49.0, 49.0, 26.0, 5.0, 25.0, 49.0, 4.0, 29.0, 37.0, 5.0], 
        [2.0, 72.0, 65.0, 50.0, 52.0, 2.0, 65.0, 10.0, 74.0, 50.0, 37.0]]
  
   def test_linkage_distance
    clusterer = Ai4r::Clusterers::CentroidLinkage.new
    clusterer.data_set = DataSet.new :data_items => @@data
    clusterer.index_clusters = clusterer.create_initial_index_clusters
    clusterer.distance_matrix = @@expected_distance_matrix
    assert_equal 92.25, clusterer.linkage_distance(0,1,2)
    assert_equal 15.25, clusterer.linkage_distance(4,2,5)
  end

end
