standard_pred = NN_standard(testv, trainv, trainlab, 1);
function predicted_labels = NN_standard(data, templ, templ_labels, k)
    % Get the number of data points and the number of classes
    [N, ~] = size(data);
    

    % Initialize predicted labels
    predicted_labels = zeros(N, 1);
    
    % Loop through each data point
    for i = 1:N
        % Compute distances between the current data point and all templates
%         distances = inf*ones(C, 1);
        i_dat = data(i,:);
        distances = pdist2(i_dat, templ, "euclidean");
        fprintf("Point %d of %d\n", i, N);
        % Find the indices of the k-nearest neighbors
        [~, indices] = mink(distances(:), k);
        
        % Count the occurrences of each class in the k-nearest neighbors
        class_counts = zeros(1, 10);
        for m = 1:k
            class_index = templ_labels(indices) + 1;
            class_counts(class_index) = class_counts(class_index) + 1;
        end
        
        % Assign the most frequent class as the predicted label
        [~, predicted_labels(i)] = max(class_counts);
        % Decrese to get correct label
        predicted_labels(i) = predicted_labels(i) - 1; 
    end
end