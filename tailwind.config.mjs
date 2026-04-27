/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'class',
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
      },
      fontFamily: {
        display: ['Geist', 'Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        sans:    ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      fontSize: {
        'display-xl': ['clamp(2.75rem, 6vw, 4.25rem)', { lineHeight: '1.02', letterSpacing: '-0.03em' }],
        'display':    ['clamp(2.25rem, 4.5vw, 3.25rem)', { lineHeight: '1.05', letterSpacing: '-0.025em' }],
        'h2':         ['clamp(1.5rem, 2.6vw, 2rem)',     { lineHeight: '1.15', letterSpacing: '-0.02em' }],
        'h3':         ['1.125rem', { lineHeight: '1.3', letterSpacing: '-0.01em' }],
        'eyebrow':    ['0.75rem',  { lineHeight: '1', letterSpacing: '0.12em' }],
      },
      maxWidth: {
        'prose': '38rem',
        'content': '72rem',
      },
      spacing: {
        'section': '5rem',
        'section-lg': '7.5rem',
        'section-xl': '9rem',
      },
      borderRadius: {
        'lg': '0.5rem',
      },
      boxShadow: {
        'soft': '0 1px 0 rgb(0 0 0 / 0.02), 0 8px 24px -12px rgb(0 0 0 / 0.08)',
        'card': '0 1px 0 rgb(0 0 0 / 0.04), 0 18px 48px -20px rgb(0 0 0 / 0.18)',
      },
      transitionTimingFunction: {
        'out-soft': 'cubic-bezier(0.22, 1, 0.36, 1)',
      },
    },
  },
  plugins: [],
};
