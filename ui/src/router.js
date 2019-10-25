// @flow

import React from 'react'
import Router from 'middle-router'

import NotFound from './apps/NotFound'

declare var require: {
	(id: string): any;
	ensure(ids: Array<string>, callback?: { (require: typeof require): void }, chunk?: string): void
}

const configureRouter = () => {
  return Router({ hash: '#!' })
    .lazy('/', () => new Promise((resolve) => require.ensure(
      [], (require) => resolve(require('./apps/Home/router').default), 'home'
    )))
    .lazy('/home', () => new Promise((resolve) => require.ensure(
      [], (require) => resolve(require('./apps/Home/router').default), 'home'
    )))
    .lazy('/user', () => new Promise((resolve) => require.ensure(
      [], (require) => resolve(require('./apps/Profile/router').default), 'user'
    )))
    .lazy('/recipes', () => new Promise((resolve) => require.ensure(
      [], (require) => resolve(require('./apps/Recipes/router').default), 'recipes'
    )))
    .use('/*', ({ path, resolve, exiting }) => {
      resolve({view: NotFound, app: 'notFound'})
    })
}

export default configureRouter

export const router = configureRouter()
