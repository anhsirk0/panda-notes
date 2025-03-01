import { themes } from "./src/Themes.res.mjs";
import daisyui from "daisyui";

/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.res.mjs"],
  theme: {
    extend: {},
    screens: {
      xs: "480px",
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1380px",
      xxl: "1536px",
    },
    keyframes: {
      slide: {
        "0%": { opacity: 0, transform: "translateY(80px)" },
        "100%": { opacity: 1, transform: "translateY(0)" },
      },
      grow: {
        "0%": { transform: "scale(0)" },
        "100%": { transform: "scale(1)" },
      },
      fade: { "0%": { opacity: 0 }, "100%": { opacity: 1 } },
    },
    animation: {
      grow: "grow 400ms ease-in-out",
      fade: "fade 200ms ease-in-out",
      slide: "slide 200ms ease-in-out",
    },
    fontFamily: {
      sans: ["Manrope", "Open Sans"],
      body: ["Manrope"],
      display: ["Manrope"],
    },
  },
  plugins: [daisyui],
  daisyui: {
    themes,
    lightTheme: "retro",
    darkTheme: "dim",
  },
};
