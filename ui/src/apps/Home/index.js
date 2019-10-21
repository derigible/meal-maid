// @flow

import * as React from 'react'

import { Grid } from '@instructure/ui-layout'
import { View } from '@instructure/ui-layout'
import { Billboard } from '@instructure/ui-billboard'
import { capitalizeFirstLetter } from '@instructure/ui-utils'

import Page from '../../components/Page'
import WeeklyPlan from './WeeklyPlan'

import type { WeeklyPlanType } from '../../types'

import type { UserType } from '../../components/User'
import type { NotificationType } from '../../components/User'

function ActionCard ({type, Icon}: {type: string, Icon: any}) {
  return (
    <View
      as="div"
      width="20rem"
      borderWidth="small"
      borderRadius="medium"
      shadow="above"
      display="inline-block"
      margin="medium"
    >
      <Billboard
        message={`View ${capitalizeFirstLetter(type)}`}
        size="large"
        href={`#!${type}`}
        hero={(size) => <Icon size={size} />}
      />
    </View>
  )
}

export default function Home (
  {user, notifications, weeklyPlan} :
  {user: UserType, notifications: Array<NotificationType>, weeklyPlan: WeeklyPlanType}
) {
  return (
    <Page
      pageName="home"
      user={user}
      notifications={notifications}
    >
      <WeeklyPlan weeklyPlan={weeklyPlan}/>
    </Page>
  )
}
