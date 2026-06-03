// Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
// Proprietary and confidential - see LICENSE for terms.
import { defineCollection, z } from 'astro:content';

const services = defineCollection({
  type: 'content',
  schema: z.object({
    title:    z.string(),
    summary:  z.string(),
    tagline:  z.string().optional(),
    group:    z.enum(['cloud-modernization', 'security-compliance', 'software-data', 'agentic-ai']),
    order:    z.number().default(0),
    icon:     z.enum(['cloud', 'shield', 'code', 'spark']).optional(),
    bullets:  z.array(z.string()).default([]),
    outcomes: z.array(z.string()).default([]),
  }),
});

export const collections = { services };
