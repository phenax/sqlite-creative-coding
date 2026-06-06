# sqlite creative coding

Generating some visuals with SQL because nobody stopped me. With the magic of [recursive CTE](https://sqlite.org/lang_with.html).

[How it works](https://ediblemonad.dev/coding4fun/2026-06-03-creative-coding-in-sqlite.html)

<table>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/gradient.sql">Gradient</a></h3>
      <img src="media/gradient.png" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/mandelbrot.sql">Mandelbrot fractal</a></h3>
      <img src="media/mandelbrot.png" />
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/polka.sql">Just some dots</a></h3>
      <img src="media/polka.png" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/voronoi.sql">Voronoi</a></h3>
      <img src="media/voronoi.png" />
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="./src/wavey.sql">Wavey</a></h3>
      <img src="media/wavey.gif" />
    </td>
    <td width="50%" valign="top">
      <h3><a href="./src/rave.sql">Trigo - the blood dragon remix</a></h3>
      <img src="media/rave.gif" />
    </td>
  </tr>
</table>

---

## Setup and run

### Dependencies
- sqlite3
- imagemagick

### Setup
- Using justfile: `just setup`
- Directly: `sqlite3 fun.db < setup.sql`

### Generate image
- Using justfile: `just image src/mandelbrot.sql`
- Directly: `sqlite3 fun.db < src/mandelbrot.sql && ./image.sh mandelbrot fun.db`

### Generate video
- Using justfile: `just video src/wavey.sql`
- Directly: `sqlite3 fun.db < src/wavey.sql && ./video.sh wavey fun.db`

