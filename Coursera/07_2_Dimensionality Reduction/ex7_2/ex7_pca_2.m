#! /usr/bin/octave
%% Machine Learning Online Class
%  Exercise 7 | Principle Component Analysis
%
%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     pca.m
%     projectData.m
%     recoverData.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc;
addpath('../../07_1_Clustering/ex7_1');





%% === Part 8(a): Optional (ungraded) Exercise: PCA for Visualization ===
%  One useful application of PCA is to use it to visualize high-dimensional
%  data. In the last K-Means exercise you ran K-Means on 3-dimensional
%  pixel colors of an image. We first visualize this output in 3D, and then
%  apply PCA to obtain a visualization in 2D.
fprintf('\n\n---------- Part 8(a): Optional (ungraded) Exercise: PCA for Visualization ----------\n\n');

fprintf('Loading data ...\n');
% Re-load the image from the previous exercise and run K-Means on it
% For this to work, you need to complete the K-Means assignment first
A = double(imread('../ex7_1/bird_small.png'));

% If imread does not work for you, you can try instead
%   load ('bird_small.mat');

fprintf('Running k-means ...\n');
A = A / 255;
img_size = size(A);
X = reshape(A, img_size(1) * img_size(2), 3);
K = 16;
max_iters = 10;
initial_centroids = kMeansInitCentroids(X, K);
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

%  Sample 1000 random indexes (since working with all the data is
%  too expensive. If you have a fast computer, you may increase this.
sel = floor(rand(1000, 1) * size(X, 1)) + 1;

%  Setup Color Palette
palette = hsv(K);
colors = palette(idx(sel), :);

fprintf('Visualizing the data and centroid memberships in 3D ...\n');
%  Visualize the data and centroid memberships in 3D
figure;
scatter3(X(sel, 1), X(sel, 2), X(sel, 3), 10, colors);
title('Pixel dataset plotted in 3D. Color shows centroid memberships');
fprintf('Program paused. Press enter to continue.\n');
pause;


%% === Part 8(b): Optional (ungraded) Exercise: PCA for Visualization ===
% Use PCA to project this cloud to 2D for visualization
fprintf('\n\n---------- Part 8(b): Optional (ungraded) Exercise: PCA for Visualization ----------\n\n');

fprintf('Normalizing features ...\n');
% Subtract the mean to use PCA
[X_norm, mu, sigma] = featureNormalize(X);

fprintf('Running PCA ...\n');
% PCA and project the data to 2D
[U, S] = pca(X_norm);

fprintf('Projecting data ...\n');
Z = projectData(X_norm, U, 2);

fprintf('Plotting ...\n');
% Plot in 2D
figure;
plotDataPoints(Z(sel, :), idx(sel), K);
title('Pixel dataset plotted in 2D, using PCA for dimensionality reduction');
fprintf('Program paused. Press enter to continue.\n');
pause;
