"""Demo."""

from pathlib import Path

import matplotlib.pyplot as plt

plt.xkcd()
plt.plot([1, 2], [3, 4])
plt.grid(True, lw="0.5")

path = Path("out")
path.mkdir(parents=True, exist_ok=True)
plt.savefig(path / "test_plot.png")
