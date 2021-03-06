classdef InPathLength < Measure
    % InPathLength < Measure: In-Path Length measure
    % InPathLength provides the in-path length of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as average shortest
    % in path length from one node to another node.
    % 
    % InPathLength methods:
    %   InPathLength                  - constructor.
    %
    % InPathLength methods (Access=protected):
    %   calculate                   - calculates the in-path length of a node.
    % 
    % InPathLength methods (Static)
    %   getClass                    - returns the in-path length class.
    %   getName                     - returns the name of in-path length measure.
    %   getDescription              - returns the description of in-path length measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if in-path length measure is global.
    %   is_nodal                    - boolean, checks if in-path length measure is nodal.
    %   is_binodal                  - boolean, checks if in-path length measure if binodal.
    %   getMeasure                  - returns the in-path length class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree.
    methods
        function m = InPathLength(g, varargin)
            % INPATHLENGTH(G) creates in-path length with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % INPATHLENGTH(G, 'Settings', SETTINGS) creates in-path length measure and
            % initializes the property settings with SETTINGS. INPATHLENGTH
            % available SETTINGS are: 
            % subgraphs     -   Calculates INPATHLENGTH of all subgraphs
            % harmonic      -   Calculates INPATHLENGTH with harmonic average
            % default       -   Calculates INPATHLENGTH with normal average
            %
            % INPATHLENGTH(G, 'VALUE', VALUE) creates in-path length, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, GlobalEfficiency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_path_length =  calculate(m)
            % CALCULATE calculates the in-path length value of a node
            %
            % PATHLENGTH = CALCULATE(M) returns the value of the in-path length
            % of a node.
            
            g = m.getGraph();  % graph from measure class    

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            in_path_length = zeros(N, 1);

            pathLength_rule = get_from_varargin('default', 'InPathLengthAvRule', m.getSettings());
            switch lower(pathLength_rule)
                case {'subgraphs'}                    
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = mean(Du(Du~=0 & Du~=Inf));
                    end
                    in_path_length(isnan(in_path_length)) = 0;  % node Nan corresponds to isolated nodes, in-pathlength is 0
                case {'harmonic'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = mean(Du(Du~=0));
                    end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InPathLength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In-Path Length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-path length measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...                
              'The in path length is the average shortest ' ...
              'in path lengths of one node to all other nodes.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InPathLength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InPathLength. 
            % INPATHLENGTHAVRULE = 'default' (default) - calculates in-path length of nodal graph.
            %                    'subgraphs' - calculates in-path length of each subgraph.
            %                    'harmonic'  - calculates the in-path length using harmonic mean.
            % 
            % See also getCompatibleGraphList()

            available_settings = {
                'InPathLengthAvRule', Constant.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if in-path length measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-path length measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-path length measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InPathLength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InPathLength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...               
                'GraphBD', ...                
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InPathLength
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InPathLength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InPathLength');
        end
    end
end