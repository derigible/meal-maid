
// @flow

import React from 'react'
import Router from 'middle-router'

import Recipes from './'
import Recipe from './Recipe'

const router = Router()
  .use('/', ({resolve}) => {
    resolve({view: Recipes, app: 'recipes'})
  })
  .use('/:id', ({params, resolve}) => {
    resolve({view: Recipe, app: 'recipes', params})
  })

export default router
