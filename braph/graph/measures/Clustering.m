classdef Clustering < Triangles
    % Clustering < Triangles: Clustering measure
    % Clustering provides the clustering coefficient of a node for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. It is calculated as the ratio between 
    % the number of triangles present around a node and the maximum number
    % of triangles that could possibly be formed around that node.
    % 
    % Clustering methods:
    %   Clustering                  - constructor with Triangles properties.
    %
    % Clustering methods (Access=protected):
    %   calculate                   - calculates the clustering coefficient of a node.
    % 
    % Clustering methods (Static)
    %   getClass                    - returns the clustering class.
    %   getName                     - returns the name of clustering measure.
    %   getDescription              - returns the description of clustering measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if clustering measure is global.
    %   is_nodal                    - boolean, checks if clustering measure is nodal.
    %   is_binodal                  - boolean, checks if clustering measure if binodal.
    %   getMeasure                  - returns the clustering class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Triangles, Measure, Graph, Transitivity, Strength, Degree.
    
    methods
        function m = Clustering (g, varargin)
            % CLUSTERING(G) creates clustering with default triangles properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % CLUSTERING(G, 'DirectedTrianglesRule', DIRECTEDTRIANGLESRULE) creates clustering             
            % measure and initializes the property DirectedTrianglesRule with DIRECTEDTRIANGLESRULE. 
            % Admissible RULE options are:
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates CLUSTERING of a node using the cycle rule for directed graphs.
            %                    'all' - calculates CLUSTERING of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates CLUSTERING of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates CLUSTERING of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates CLUSTERING of a node
            %                    using the out rule for directed graphs.
            % 
            % CLUSTERING(G, 'VALUE', VALUE) creates clustering, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Triangles, Measure, Graph, Transitivity, Strength, Degree.
            
            m = m@Triangles(g, varargin{:});
        end
    end
    methods (Access=protected)
        function clustering = calculate(m)
            % CALCULATE calculates the clustering coefficient of a node
            %
            % CLUSTERING = CALCULATE(M) returns the coefficient of the clustering 
            % of a node.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            
            if g.is_measure_calculated('Triangles')
                triangles = g.getMeasureValue('Triangles');
            else
                triangles = calculate@Triangles(m);
            end
            
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                
                if g.is_measure_calculated('Degree')
                    degree = g.getMeasureValue('Degree');                    
                else
                    degree = Degree(g, g.getSettings()).getValue();
                end
                
                clustering = 2 * triangles ./ (degree .* (degree - 1));
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')  
                
                if g.is_measure_calculated('InDegree')
                    in_degree = g.getMeasureValue('InDegree');
                else 
                    in_degree = InDegree(g, g.getSettings()).getValue();
                end
                
                if g.is_measure_calculated('OutDegree')
                    out_degree = g.getMeasureValue('OutDegree');
                else
                    out_degree = OutDegree(g, g.getSettings()).getValue();
                end
                
                directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        clustering = triangles ./ ((out_degree + in_degree) .* (out_degree + in_degree - 1) - 2 * diag(A^2));
                    case {'middleman'}  % middleman rule
                        clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
                    case {'in'}  % in rule
                        clustering = triangles ./ (in_degree .* (in_degree - 1));
                    case {'out'}  % out rule
                        clustering = triangles ./ (out_degree .* (out_degree - 1));
                    otherwise  % {'cycle'}  % cycle rule
                        clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
                end
                
            end
            
            clustering(isnan(clustering)) = 0;  % Should return zeros, not NaN
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the clustering measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Clustering';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the clustering measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Clustering';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the clustering description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % clustering measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The clustering coefficient of a node is ' ...
                'the fraction of triangles present around a node.' ...
                'The clustering coefficient is calculated as the ratio between' ...
                'the number of triangles present around a node and' ...
                'the maximum number of triangles that could possibly' ...
                'be formed around that node.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Clustering
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Clustering. 
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates CLUSTERING of a node using the cycle rule for directed graphs.
            %                    'all' - calculates CLUSTERING of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates CLUSTERING of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates CLUSTERING of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates CLUSTERING of a node
            %                    using the out rule for directed graphs.
            % 
            % See also getCompatibleGraphList()

            available_settings = {
                'DirectedTrianglesRule', Constant.STRING, 'cycle', {'cycle', 'all', 'middleman', 'in', 'out'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if clustering measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
                                   
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if clustering measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
                                   
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if clustering measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Clustering 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Clustering. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Clustering 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Clustering.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Clustering');
        end
    end  
end