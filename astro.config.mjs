// Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
// Proprietary and confidential - see LICENSE for terms.
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://vergent.co.ke',
  integrations: [
    tailwind({ applyBaseStyles: false }),
  ],
  build: {
    inlineStylesheets: 'auto',
  },
  compressHTML: true,
});
