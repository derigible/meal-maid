const webpack = require("webpack");
const baseConfig = require("@instructure/ui-webpack-config");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

require("dotenv").config();

const webpackDevServerUrl = process.env.SERVER_URL || "http://localhost:8080/";

const buildPlugins = [
  new HtmlWebpackPlugin({
    chunksSortMode: "dependency",
    filename: path.join(__dirname, "..", "public", "index.html"),
    inject: true,
    template: "src/index.html"
  }),
  new webpack.HotModuleReplacementPlugin()
];

const buildConfig = {
  mode: "development",
  devServer: {
    clientLogLevel: "warning",
    contentBase: "./src/",
    headers: { "Access-Control-Allow-Origin": "*" },
    historyApiFallback: true,
    host: "0.0.0.0",
    hot: true,
    inline: true,
    noInfo: false,
    publicPath: webpackDevServerUrl,
    public: "localhost:8080",
    stats: {
      assets: true,
      cached: true,
      cachedAssets: false,
      children: false,
      chunkModules: false,
      chunkOrigins: false,
      chunks: false,
      colors: true,
      errorDetails: true,
      errors: true,
      hash: true,
      modules: false,
      publicPath: true,
      reasons: false,
      source: false,
      timings: true,
      version: false,
      warnings: false
    },
    writeToDisk: filePath => {
      return /index\.html$/.test(filePath);
    }
  }
};
const buildOutput = {
  chunkFilename: "[name].js",
  filename: "[name].js",
  publicPath: webpackDevServerUrl
};

module.exports = {
  ...baseConfig,
  ...buildConfig,
  output: {
    ...baseConfig.output,
    ...buildOutput
  },
  plugins: [...baseConfig.plugins, ...buildPlugins],
  module: {
    // note: put your rules first
    rules: [...baseConfig.module.rules]
  },
  resolveLoader: {
    alias: { ...baseConfig.resolveLoader.alias }
  }
};
