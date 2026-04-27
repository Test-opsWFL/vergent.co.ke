import { defineCollection, z } from 'astro:content';

const services = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    summary: z.string(),
    group: z.enum(['cloud-modernization', 'security-compliance', 'software-data']),
    order: z.number().default(0),
    bullets: z.array(z.string()).default([]),
  }),
});

export const collections = { services };
