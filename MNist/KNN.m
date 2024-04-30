tic
pred = pred_KNN(testv, templates, 1);
toc
function predicted_labels = pred_KNN(data, templ, k)
    % Get the number of data points and the number of classes
    [N, ~] = size(data);
    [C, K, ~] = size(templ);
    
    % Initialize predicted labels
    predicted_labels = zeros(N, 1);
    
    % Loop through each data point
    for i = 1:N
        % Compute distances between the current data point and all templates
        distances = zeros(C, K);
        i_dat = squeeze(data(i, :));
        for j = 1:C
            for l = 1:K
                i_templ = squeeze(templ(j, l, :));
                distances(j, l) = dist(i_dat, i_templ);
            end
            fprintf("Point %d of %d\n", i, N);
        end
        
        % Find the indices of the k-nearest neighbors
        [~, indices] = mink(distances(:), k);
        
        % Count the occurrences of each class in the k-nearest neighbors
        class_counts = zeros(1, C);
        for m = 1:k
            class_index = mod(indices(m), C);
            if class_index == 0
                class_index = C;
            end
            class_counts(class_index) = class_counts(class_index) + 1;
        end
        
        % Assign the most frequent class as the predicted label
        [~, predicted_labels(i)] = max(class_counts);
        % Decrese to get correct label
        predicted_labels(i) = predicted_labels(i) - 1; 
    end
    
end
