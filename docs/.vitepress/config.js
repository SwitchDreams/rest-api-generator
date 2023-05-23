import {defineConfig} from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "RestApiGenerator",
  description: "Build a Ruby on Rails REST API faster",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      {text: 'Home', link: '/'},
      {text: 'Quick Start', link: '/quick-start'}
    ],
    sidebar: [
      {
        items: [
          {text: 'Introduction', link: '/introduction'},
          {text: 'Quick Start', link: '/quick-start'},
          {text: 'Modular error handler', link: '/modular-error-handling'},
        ]
      },
      {
        text: 'Command',
        link: '/command/index',
        // hide bar
        collapsible: true,
        collapsed: true,
        items: [
          {text: 'Scope', link: '/command/scope'},
          {text: 'Nested Resource', link: '/command/child-resource'},
          {text: 'Eject', link: '/command/eject'},
          {text: 'Automatic Specs/Docs', link: '/command/specs'},
        ]
      },
      {
        text: 'Features',
        items: [
          {text: 'Ordering', link: '/features/ordering'},
          {text: 'Filtering', link: '/features/filtering'},
          {text: 'Pagination', link: '/features/pagination'},
          {text: 'Serialization', link: '/features/serialization'},
          {text: 'Callbacks', link: '/features/callbacks'},
        ]
      },
      {
        text: 'Others',
        items: [
          {text: 'Config', link: '/config'},
        ]
      },
    ],
    socialLinks: [
      {icon: 'github', link: 'https://github.com/SwitchDreams/rest-api-generator'}
    ]
  }
})
