// @flow

import React from 'react'

import { List } from '@instructure/ui-elements'
import { Button } from '@instructure/ui-buttons'
import { IconPlusLine, IconUserLine, IconInboxLine } from '@instructure/ui-icons'
import { TextArea } from '@instructure/ui-forms'
import { Text } from '@instructure/ui-elements'
import { TextInput } from '@instructure/ui-text-input'

import Page from '../../../components/Page'
import PageHeader from '../../../components/PageHeader'
import StandardEditModal from '../../../components/StandardEditModal'
import Notification from '../../../components/User/Notification'

import type { UserType } from '../../../components/User'
import type { NotificationType } from '../../../components/User'

const crumbs = [{href: '#!user', linkText: 'User', icon: IconUserLine}, {href: '#!user/inbox', linkText: 'Inbox', icon: IconInboxLine}]

export default function Inbox (
  {user, notifications} : {user: UserType, notifications: Array<NotificationType>}
) {
  return (
    <Page
      user={user}
      notifications={notifications}
      pageName="user/inbox"
      pageHeader={
        <PageHeader breadCrumbs={crumbs} />
      }
    >
      {
        notifications.length > 0
          ? (
            <List variant="unstyled">
              {notifications.map(t => <List.Item key={t.id}><Notification notification={t} /></List.Item>)}
            </List>
          )
          : (
            <Text>Nothing to see here.</Text>
          )
      }
    </Page>
  )
}
