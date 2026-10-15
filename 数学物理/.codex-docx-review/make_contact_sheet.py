from pathlib import Path
from PIL import Image, ImageDraw, ImageFont


def main(start: int, end: int, output: str) -> None:
    media = Path(__file__).parent / "media"
    thumb_w, thumb_h = 360, 240
    cols = 4
    count = end - start + 1
    rows = (count + cols - 1) // cols
    sheet = Image.new("RGB", (cols * thumb_w, rows * thumb_h), "white")
    draw = ImageDraw.Draw(sheet)
    font = ImageFont.load_default()

    for offset, index in enumerate(range(start, end + 1)):
        path = media / f"image{index}.png"
        if not path.exists():
            continue
        with Image.open(path) as source:
            image = source.convert("RGB")
            image.thumbnail((thumb_w - 20, thumb_h - 34))
            x = (offset % cols) * thumb_w + (thumb_w - image.width) // 2
            y = (offset // cols) * thumb_h + 24
            sheet.paste(image, (x, y))
        draw.text(((offset % cols) * thumb_w + 8, (offset // cols) * thumb_h + 6), f"image{index}", fill="black", font=font)

    sheet.save(Path(__file__).parent / output)


if __name__ == "__main__":
    import sys

    main(int(sys.argv[1]), int(sys.argv[2]), sys.argv[3])
