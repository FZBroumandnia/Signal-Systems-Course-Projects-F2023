clc, close all
IC_FILE = 'IC.png';
PICTURE_FILE = 'PCB.jpg';
template = imread(IC_FILE);
image = imread(PICTURE_FILE);

subplot(2,2,1);
imshow(template);
title('IC');
subplot(2,2,3);
imshow(image);
title('Board');

template_gray = rgb2gray(template);
image_gray = rgb2gray(image);
corr_coef = normxcorr2(template_gray, image_gray);
% normalized_corr =  normalizedCorr(template_gray, image_gray);
threshold = 0.7;
[y, x] = find(corr_coef > threshold);
template_rotated = imrotate(template_gray, 180);
corr_coef_rotated = normxcorr2(template_rotated, image_gray);
[y_rotated, x_rotated] = find(corr_coef_rotated > threshold);

subplot(2,2,2);
imshow(image);
title('Detected IC');
hold on;

for i = 1:length(x)
    rectangle('Position', [x(i)-size(template_gray, 2)+1, y(i)-size(template_gray, 1)+1, size(template_gray, 2), size(template_gray, 1)], 'EdgeColor', 'r', 'LineWidth', 1);
end

for i = 1:length(x_rotated)
    rectangle('Position', [x_rotated(i)-size(template_gray, 2)+1, y_rotated(i)-size(template_gray, 1)+1, size(template_gray, 2), size(template_gray, 1)], 'EdgeColor', 'r', 'LineWidth', 1);
end

function normalized_corr = normalizedCorr(image, template)
    mean_template = mean(template(:));
    mean_image = mean(image(:));

    numerator = sum(sum((image - mean_image) .* (template - mean_template)));
    denominator_image = sqrt(sum(sum((image - mean_image).^2)));
    denominator_template = sqrt(sum(sum((template - mean_template).^2)));

    normalized_corr = numerator / (denominator_image * denominator_template);
end


