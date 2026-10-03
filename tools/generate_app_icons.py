"""Generate iOS app icons from Shelf's three-bar brand mark."""

import json
from pathlib import Path

from PIL import Image, ImageDraw


ROOT = Path(__file__).resolve().parents[1]
ICON_SET = ROOT / "ios/Runner/Assets.xcassets/AppIcon.appiconset"
SCALE = 4
SIZE = 1024

image = Image.new("RGB", (SIZE * SCALE, SIZE * SCALE), "#F5F0EF")
draw = ImageDraw.Draw(image)

for index, color in enumerate(("#CCFF00", "#C7CEEA", "#B5EAD7")):
    top = 262 + index * 174
    box = tuple(value * SCALE for value in (218, top, 806, top + 146))
    draw.rounded_rectangle(
        box,
        radius=25 * SCALE,
        fill=color,
        outline="#1A1A1A",
        width=8 * SCALE,
    )

master = image.resize((SIZE, SIZE), Image.Resampling.LANCZOS)
contents = json.loads((ICON_SET / "Contents.json").read_text())
for entry in contents["images"]:
    points = float(entry["size"].split("x")[0])
    pixels = round(points * int(entry["scale"][0]))
    master.resize((pixels, pixels), Image.Resampling.LANCZOS).save(
        ICON_SET / entry["filename"]
    )
