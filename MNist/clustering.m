tic
templates = cluster(trainv, trainlab, 64, 10);
toc
% class_data = separate_classes(trainv, trainlab, 10);

function templates = cluster(train_d, train_l, M, num_classes)

    point_size = size(train_d, 2);
    
    templates = -1*ones([num_classes, M, point_size]);
    class_data = separate_classes(train_d, train_l, 10);
    

    % Run clustering
    for i = 1:num_classes
        data_i = cell2mat(class_data(i,:,:));
        [~, templates(i,:,:)] = kmeans(data_i, M);
        fprintf("Finished clustering class %d out of 10\n", i);
    end

end


function classes_data = separate_classes(data, labels, num_labels)
   
    % Initialize cell array to store data for each label
    classes_data = cell(num_labels, 1);
    
    % Loop through each label
    for label = 0:num_labels-1
        % Find indices where label matches
        indices = (labels == label);
        
        % Extract data corresponding to the current label
        classes_data{label+1} = data(indices, :);
        
        fprintf("Finished separating class %d out of %d\n", label, num_labels);
    end
    fprintf("---\n")
end