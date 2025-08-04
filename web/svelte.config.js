import { svelte, vitePreprocess } from '@sveltejs/vite-plugin-svelte';
import { sass } from 'svelte-preprocess-sass';

export default {
  preprocess: vitePreprocess(),
  plugins: [
    ...
    svelte({
      preprocess: {
        style: sass(),
      },
    }),
  ],
}
