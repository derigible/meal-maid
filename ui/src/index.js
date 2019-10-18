// @flow

import * as React from 'react'
import ReactDOM from 'react-dom'
import theme from '@instructure/canvas-theme'
import ApolloClient from 'apollo-boost'
import { ApolloProvider, useQuery } from '@apollo/react-hooks'
import { gql } from "apollo-boost";
import { Spinner } from '@instructure/ui-elements'

import configureRouter from './router'

theme.use()

const mountPoint = document.getElementById('app')

const router = configureRouter()

const client = new ApolloClient();

const user = {
  display_name: 'Marc Phillips',
  email: 'mphillips@outlook.com',
  preferred_name: 'derigible'
}

const notifications = []

const userInfoQuery = gql`
  {
    user {
      display_name
      email
      preferred_name
    }
  }
`

function LoginCheck ({View}) {
  const { loading, error, data } = useQuery(userInfoQuery);

  if (loading) return <Spinner renderTitle="Loading" size="large" margin="0 0 0 medium" />;
  if (error){
    console.log(error) // eslint-disable-line
    return <p>Error :(</p>;
  }

  return <View user={data.user} notifications={notifications} />
}

if (mountPoint !== null) {
  router.on('route', async (_, routing) => {
    const { view, app } = await routing

    ReactDOM.render(
      <ApolloProvider client={client}>
        <LoginCheck View={view} />
      </ApolloProvider>,
      mountPoint
    )
  }).start()
}
