module.exports = {
  pageExtensions: ['jsx', 'mdx'],
  webpack(config, options) {
    // support class="..."
    options.defaultLoaders.babel.options.plugins = ['babel-plugin-react-html-attrs']

    // mdx support
    config.resolve.extensions.push('.mdx')
    config.module.rules.push({
      test: /\.mdx$/,
      use: [
        options.defaultLoaders.babel,
        {
          loader: '@mdx-js/loader',
          options: {},
        },
      ],
    })

    return config
  },
}
