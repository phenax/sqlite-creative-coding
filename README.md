# sqlite creative coding

Generating some visuals with SQL because nobody stopped me. With the magic of [recursive CTE](https://sqlite.org/lang_with.html).

[How it works](https://ediblemonad.dev/coding4fun/2026-06-03-creative-coding-in-sqlite.html)

<table>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/gradient.image.sql">Gradient</a></h3>
      <img src="media/gradient.png" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/mandelbrot.image.sql">Mandelbrot fractal</a></h3>
      <img src="media/mandelbrot.png" />
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/polka.image.sql">Just some dots</a></h3>
      <img src="media/polka.png" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/voronoi.image.sql">Voronoi</a></h3>
      <img src="media/voronoi.png" />
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/wavey.video.sql">Wavey</a></h3>
      <img src="media/wavey.gif" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/rave.video.sql">Trigo - the blood dragon remix</a></h3>
      <img src="media/rave.gif" />
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/supermariobros.audio.sql">Super Mario Bros. theme</a></h3>
      
https://github.com/user-attachments/assets/1e181a1a-8e7b-4d98-9ab7-20ca6343d52d

&nbsp;
    </td>
    <td width="50%" valign="top">
    </td>
  </tr>
</table>

---

## Setup and run

### Dependencies
- sqlite3
- imagemagick (for image)
- ffmpeg+ffplay (for video,audio)

### Setup
- Using justfile: `just setup`
- Directly: `sqlite3 fun.db < setup.sql`

### Generate image
- Using justfile: `just image src/mandelbrot.image.sql`
- Directly: `sqlite3 fun.db < src/mandelbrot.image.sql && ./image.sh mandelbrot fun.db`

### Generate video
- Using justfile: `just video src/wavey.video.sql`
- Directly: `sqlite3 fun.db < src/wavey.video.sql && ./video.sh wavey fun.db`

### Generate audio
- Using justfile: `just audio src/supermariobros.audio.sql`
- Directly: `sqlite3 fun.db < src/supermariobros.audio.sql && ./audio.sh supermariobros fun.db`
