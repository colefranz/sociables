var path = require("path");
const CopyWebpackPlugin = require('copy-webpack-plugin')


module.exports = {
  entry: {
    app: [
      './app.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /dist/,
        query: {
          presets: ['env'],
          plugins: []
        }
      },
      {
        test: /\.styl$/,
        use: [
          'style-loader',
          'css-loader',
          {
            loader: 'stylus-loader',
            options: {
              use: [require('nib')()],
            },
          }
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
        options: {
          debug: true,
        },
      },
    ],

    noParse: /\.elm$/,
  },
  plugins: [
    new CopyWebpackPlugin([ { from: 'assets', to: 'assets' } ])
  ],

  devServer: {
    inline: true,
    stats: { colors: true },
    port: 8000,
  },
};
