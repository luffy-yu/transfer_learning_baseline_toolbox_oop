classdef ShowResult
    %SHOWRESULT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        title
        domains
        fontSize
        old_label
        new_label
    end
    
    methods
        function obj = ShowResult()
            %SHOWRESULT Construct an instance of this class
            %   Detailed explanation goes here
            obj.title = '';
            obj.domains = '';
            obj.old_label = 'Old';
            obj.new_label = 'New';
        end
        
        function show(obj,dataset, method, old_acc, new_acc)
            domains = dataset.get_transfer_domains();
            obj.title = ['Method: ' method.methodName ', Dataset: ' dataset.datasetName];
            % format table
            t = format_output(domains, old_acc, new_acc, obj.old_label, obj.new_label);
            % save csv
            writetable(t,['compare_of_method_' strrep(method.methodName,' ', '_') '_dataset_' strrep(dataset.datasetName, ' ', '_') '.csv'],'Delimiter',',');
            g = draw_result(t, obj.title, dataset.show_rotation,dataset.show_dodge);
            % save
            saveas(gcf,['compare_of_method_' strrep(method.methodName,' ', '_') '_dataset_' strrep(dataset.datasetName, ' ', '_') '.png']);
        end
    end
end

function t = format_output(trans, list_acc, list_acc_new, old_label, new_label)
%FORMAT_EASYTL_OUTPUT Summary of this function goes here
%   Detailed explanation goes here

% original
Accurate = list_acc;
Direction = trans';
Method = repmat({old_label}, size(trans,2), 1);

% new
if size(list_acc_new, 1)
    Accurate_new = list_acc_new;
    Direction_new = trans';
    Method_new = repmat({new_label}, size(trans,2), 1);
    
    % merge
    Method = [Method; Method_new];
    Direction = [Direction; Direction_new];
    Accurate =  [Accurate; Accurate_new];
end

t = table(Method, Direction, Accurate);
end

function g = draw_result(table, title, rotation, dodge)

if nargin < 4
    dodge = 1;
end

if nargin < 3
    rotation = 0;
end

% draw result

% Method, Direction, Accurate
g = gramm('x', table.Direction, 'y', table.Accurate, 'color', table.Method, 'label', table.Accurate);
g.geom_point();
g.geom_label('color','k','dodge',dodge,'VerticalAlignment','bottom','HorizontalAlignment','center');
g.set_names('color','Method','x', 'source domain - target domain','y','Accurate');
% rotation
g.axe_property('XTickLabelRotation',rotation);
% set x order
g.set_order_options('x', 0);
g.geom_line();
g.set_title(title);

figure('Position',[100 100 1600 800]);
g.draw();
end


