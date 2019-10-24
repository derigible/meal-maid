
// @flow

import React from 'react'
import Router from 'middle-router'
import { IconUserLine, IconGroupLine } from '@instructure/ui-icons'

import Profile from './'
import Inbox from './Inbox'

const router = Router()
  .use('/', ({resolve}) => {
    resolve({view: Profile, pageName: 'user'})
  })
  .use('/inbox', ({resolve}) => {
    resolve({view: Inbox, pageName: 'user/inbox'})
  })

export default router
