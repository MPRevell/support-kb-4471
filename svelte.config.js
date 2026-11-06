import adapter from '@sveltejs/adapter-static';
import { mdsvex } from 'mdsvex';
import { fileURLToPath } from 'node:url';
const runbook = fileURLToPath(new URL('./src/lib/layouts/runbook.svelte', import.meta.url));

export default {
  extensions: ['.svelte', '.svx'],
  preprocess: [mdsvex({ extensions: ['.svx'], layout: { runbook } })],
  kit: {
    adapter: adapter({ pages: 'build', strict: false }),
    alias: { '#lib': 'src/lib' },
    prerender: { entries: ['/kb'], handleHttpError: 'warn' },
  },
};
