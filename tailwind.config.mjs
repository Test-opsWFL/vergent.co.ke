// Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
// Proprietary and confidential - see LICENSE for terms.
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'media',
  theme: {
    extend: {
      colors: {
        ink:     'rgb(var(--ink) / <alpha-value>)',
        muted:   'rgb(var(--muted) / <alpha-value>)',
        surface: 'rgb(var(--surface) / <alpha-value>)',
        card:    'rgb(var(--card) / <alpha-value>)',
        border:  'rgb(var(--border) / <alpha-value>)',
        accent:  'rgb(var(--accent) / <alpha-value>)',
        'accent-soft': 'rgb(var(--accent-soft) / <alpha-value>)',
        'brand-navy': 'rgb(var(--brand-navy) / <alpha-value>)',
        'brand-blue': 'rgb(var(--brand-blue) / <alpha-value>)',
      },
      fontFamily: {
        display: ['Geist', 'Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        sans:    ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      fontSize: {
        'display-xl': ['clamp(1.75rem, 3.5vw, 2.75rem)',   { lineHeight: '1.08', letterSpacing: '-0.03em' }],
        'display':    ['clamp(1.375rem, 2.2vw, 2.125rem)', { lineHeight: '1.12', letterSpacing: '-0.025em' }],
        'h2':         ['clamp(1.125rem, 1.8vw, 1.4rem)',   { lineHeight: '1.25', letterSpacing: '-0.02em' }],
        'h3':         ['0.9375rem', { lineHeight: '1.35', letterSpacing: '-0.01em' }],
        'eyebrow':    ['0.6875rem', { lineHeight: '1',    letterSpacing: '0.14em' }],
      },
      maxWidth: {
        'prose':   '38rem',
        'content': '80rem',
        'wide':    '88rem',
      },
      spacing: {
        'section':    '2.5rem',
        'section-lg': '3.25rem',
        'section-xl': '4.5rem',
      },
      borderRadius: {
        'lg': '0.5rem',
      },
      boxShadow: {
        'soft': '0 1px 0 rgb(0 0 0 / 0.02), 0 8px 24px -12px rgb(0 0 0 / 0.08)',
        'card': '0 1px 0 rgb(0 0 0 / 0.04), 0 18px 48px -20px rgb(0 0 0 / 0.18)',
        'mockup': '0 30px 80px -24px rgba(15, 23, 42, 0.30), 0 0 0 1px rgba(15, 23, 42, 0.06)',
      },
      transitionTimingFunction: {
        'out-soft': 'cubic-bezier(0.22, 1, 0.36, 1)',
      },
    },
  },
  plugins: [],
};
