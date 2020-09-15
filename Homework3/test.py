from clustring import KMeans

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import style

style.use('ggplot')
X = np.array([[1, 2, 3],
              [1.5, 1.8, 9]])

# plt.scatter(X[:, 0], X[:, 1], s=150)
# plt.show()

model = KMeans()
model.fit(X)
print(model.classifications)
print(model.predict([9, 11, 12]))


# for centroid in model.centroids:
#     plt.scatter(model.centroids[centroid][0], model.centroids[centroid][1],
#                 marker="o", color="k", s=150, linewidths=5)
#
# for classification in model.classifications:
#     # color = colors[classification]
#     for featureset in model.classifications[classification]:
#         plt.scatter(featureset[0], featureset[1], marker="x", s=150, linewidths=5)
#
# plt.show()