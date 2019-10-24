// @flow

import React from 'react'

import { View } from '@instructure/ui-layout'
import { Tabs } from '@instructure/ui-tabs'

import PageHeader from '../../components/PageHeader'
import Page from '../../components/Page'
import User from '../../components/User'

import type { UserType, NotificationType } from '../../components/User'

const tabs = {
  user_info: 0
}

// error in webpack with eslint, need to keep so $Keys is not undef
// eslint-disable-next-line no-undef
type TabTypes = $Keys<typeof tabs>;

export default function Profile (
  {user, notifications, tab = 'user_info'} : {user: UserType, notifications: Array<NotificationType>, tab?: TabTypes}
) {
  const [selected: string, setSelected] = React.useState(tabs[tab])
  const [toggle, setRerender] = React.useState(false)

  const rerender = () => setRerender(!toggle)

  return (
    <Tabs
      onRequestTabChange={(_, { index }) => setSelected(index)}
    >
      <Tabs.Panel
        id='user_info'
        selected={selected === tabs.user_info}
        renderTitle="User Information"
      >
        <View as="div">
          <User user={user}/>
        </View>
      </Tabs.Panel>
    </Tabs>
  )
}
