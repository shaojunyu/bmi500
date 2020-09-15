# This is an implementation of k-means clustering algorithm
# Shaojun Yu
# sklearn style (fit and predict)

import numpy as np


class KMeans:
    def __init__(self, k=2, tol=0.0001, max_iter=300):
        """
        :param k: number of clusters
        :param tol: Relative tolerance with regards to Frobenius norm
        :param max_iter: Maximum number of iterations of the k-means algorithm for a single run.
        """
        self.classifications = {}
        self.centroids = {}
        self.k = k
        self.tol = tol
        self.max_iter = max_iter

    def fit(self, data):
        """
        Compute k-means clustering.
        :param data: input data
        """

        # init centroids at random
        for i in range(self.k):
            self.centroids[i] = data[i]

        # iterations
        for i in range(self.max_iter):

            for j in range(self.k):
                self.classifications[j] = []

            for sample in data:
                distances = [np.linalg.norm(sample - self.centroids[centroid]) for centroid in self.centroids]
                classification = distances.index(min(distances))
                self.classifications[classification].append(sample)

            prev_centroids = dict(self.centroids)

            for classification in self.classifications:
                self.centroids[classification] = np.average(self.classifications[classification], axis=0)

            optimized = True

            for c in self.centroids:
                original_centroid = prev_centroids[c]
                current_centroid = self.centroids[c]
                if np.sum((current_centroid - original_centroid) / original_centroid * 100.0) > self.tol:
                    # print(np.sum((current_centroid - original_centroid) / original_centroid * 100.0))
                    optimized = False

            if optimized:
                break

    def predict(self, data):
        """
        Predict the closest cluster each sample in X belongs to.
        :param data: input data
        :return: classification
        """
        distances = [np.linalg.norm(data - self.centroids[centroid]) for centroid in self.centroids]
        classification = distances.index(min(distances))
        return classification
