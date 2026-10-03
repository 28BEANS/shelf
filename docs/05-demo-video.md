# Demo video

**File:** `demo.mp4` in this folder, or the hosted link (see below)
**Length:** aim for 3 to 5 minutes
**Recorded on:** the device you used

## What it shows

A short list, in order, so a viewer can skip to what they need:

- 0:00 what the app is and who it is for
- 0:20 ...
- 1:10 ...

Cover, in this order: the main user journey end to end, anything that only works
on a real device (camera, GPS, sensors), and the thing you are proudest of.

## Getting it into the repo

GitHub **blocks any file over 100 MB** and warns over 50 MB, so compress before
you commit:

```bash
ffmpeg -i raw.mp4 -vcodec libx264 -crf 28 -preset slow \
       -vf scale=-2:720 -acodec aac -b:a 96k demo.mp4
```

Raise `-crf` (28 to 32) or drop to `-2:480` if it is still too large. If it still
does not fit, attach it to a **GitHub Release** or upload it unlisted and link it
here. Never commit the raw capture: git keeps it forever even after you delete
it.

## Before you record

- Real data off the screen: no classmates' names, numbers, faces or messages.
- Notifications off.
- Sensible sample data, not "asdf".
- One unbroken take per feature. Say what you are doing while you do it.

## October 4 recording outline and status

The final 3–5 minute recording has **not yet been captured or published**. Use
the signed Shelf 2.0 iPhone app, blur account details, and show these steps:

1. Introduce the equipment-finding problem and the local-first approach.
2. Show Google registration only if a safe test account is ready; otherwise
   show the launch animation, passcode unlock, and saved workspace.
3. Open a saved room photo view, demonstrate movable storage labels and view
   removal, then add or review an item from an iPhone camera capture.
4. Search, move, check out, and return an item; close and reopen to show local
   persistence.
5. Spend 2–3 minutes explaining AI assistance, a corrected AI mistake, the
   Drift inventory model, and the limits: no textured 3D room reconstruction,
   no cloud inventory sync, and incomplete scanner failure/barcode tests.

The course rubric also calls for a slide deck, a square title image, and a
public Google Drive link for the video. Those deliverables are not represented
as completed here.
