import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({ include: ["**/*.res.mjs"] }),
    VitePWA({
      registerType: "autoUpdate",
      manifest: {
        name: "Panda notes",
        short_name: "PandaNotes",
        start_url: "/",
        display: "standalone",
        background_color: "#ffffff",
        theme_color: "#ffffff",
        scope: "/",
        icons: [{ src: "/logo.svg", type: "image/svg+xml", sizes: "any" }],
      },
    }),
  ],
});
