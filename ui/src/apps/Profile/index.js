// @flow

import React from 'react'
import { gql } from "apollo-boost";
import { useQuery } from '@apollo/react-hooks'

import { View } from '@instructure/ui-layout'
import { Tabs } from '@instructure/ui-tabs'
import { Spinner } from '@instructure/ui-elements'

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

const userInfoQuery = gql`
  {
    user {
      displayName
      preferredName
      email
    }
  }
`

export default function Profile (
  {tab = 'user_info'} : {tab?: TabTypes}
) {
  const [selected: string, setSelected] = React.useState(tabs[tab])
  const { loading, error, data } = useQuery(userInfoQuery)

  if (loading) return <Spinner renderTitle="Loading" size="large" margin="0 0 0 medium" />;
  if (error){
    if (new RegExp('Received status code 401').test(error.toString())) {
      setTimeout(() => window.location = '/auth/identity', 1000)
      return <p>User not authenticated. Being redirected to login in 1 second...</p>;
    }
    return <p>Something has gone wrong. Reload the page, clear cookies and cache, and try again.</p>
  }

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
          <User user={data.user || {}}/>
        </View>
      </Tabs.Panel>
    </Tabs>
  )
}
