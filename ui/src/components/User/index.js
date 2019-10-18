// @flow

import React from 'react'

import { Button } from '@instructure/ui-buttons'
import { Grid } from '@instructure/ui-layout'
import { Text } from '@instructure/ui-elements'
import { IconSaveLine } from '@instructure/ui-icons'

import StandardEdit from '../StandardEdit'

export type UserType = {
  display_name: string,
  email: string,
  preferred_name: string
}
type NotificationData = {
  type?: string,
  details: string
}

export type NotificationType = {
  data: NotificationData,
  id: string,
  read: boolean,
  created_at: string,
  updated_at: string
}

type ComponentActionType = {
  type: string,
  payload: string
}

function reducer(state: UserType, action: ComponentActionType) {
  switch (action.type) {
    case 'display_name':
      return {...state, display_name: action.payload}
    case 'email':
      return {...state, email: action.payload}
    case 'preferred_name':
      return {...state, preferred_name: action.payload}
    default:
      throw new Error();
  }
}

export default function User ({user} : {user: UserType}) {
  const [userObj: UserType, setUserChanges] = React.useReducer(reducer, user)
  const [userChanged: boolean, setUserChanged] = React.useState(false)

  return (
    <>
      <Grid>
        <Grid.Row>
          <Grid.Col>
            <StandardEdit
              label="Display Name"
              value={userObj.display_name}
              onChange={(e) => {setUserChanged(true); setUserChanges({type: 'display_name', payload: e.target.value})}}
            />
          </Grid.Col>
          <Grid.Col>
            <StandardEdit
              label="Preferred Name"
              value={userObj.preferred_name}
              onChange={(e) => {setUserChanged(true); setUserChanges({type: 'preferred_name', payload: e.target.value})}}
            />
          </Grid.Col>
        </Grid.Row>
        <Grid.Row>
          <Grid.Col>
            <StandardEdit
              label="Email"
              value={userObj.email}
              onChange={(e) => {setUserChanged(true); setUserChanges({type: 'email', payload: e.target.value})}}
            />
          </Grid.Col>
        </Grid.Row>
      </Grid>
      <Button
        disabled={!userChanged}
        variant="primary"
        icon={IconSaveLine}
        onClick={() => {}}
        margin="medium none"
      >
        Save Changes
      </Button>
    </>
  )
}
