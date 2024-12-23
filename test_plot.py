"""xkcd demo."""

from pathlib import Path

import matplotlib.pyplot as plt

plt.xkcd()
plt.plot([1, 2], [3, 4])
plt.xlabel("x")
plt.ylabel("y")
plt.grid(True, lw="0.5")
plt.title('A "straight" line')

out_dir = Path("out")
out_dir.mkdir(exist_ok=True, parents=True)
plt.savefig(out_dir / "test_plot.png", bbox_inches="tight")
