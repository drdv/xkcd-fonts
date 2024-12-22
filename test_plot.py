"""xkcd demo."""

import matplotlib.pyplot as plt

plt.xkcd()
plt.plot([1, 2], [3, 4])
plt.xlabel("x")
plt.ylabel("y")
plt.grid(True, lw="0.5")
plt.title('A "straight" line')

plt.savefig("img/test_plot.png", bbox_inches="tight")
