import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

// https://vite.dev/config/
export default defineConfig({
  plugins: [svelte()],
  envDir: '../',
  root: './web',
  build: {
    outDir: '../dist',
    emptyOutDir: true,
  },
})
