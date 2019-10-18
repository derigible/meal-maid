// @flow

import * as React from 'react';

import { Responsive, Flex, View } from '@instructure/ui-layout'
import { Navigation } from '@instructure/ui-navigation'
import { IconEmailLine } from '@instructure/ui-icons'
import { IconRubricLine } from '@instructure/ui-icons'
import { IconInboxLine } from '@instructure/ui-icons'
import { IconComposeLine } from '@instructure/ui-icons'
import { IconHamburgerSolid } from '@instructure/ui-icons'
import { IconXLine } from '@instructure/ui-icons'
import { ScreenReaderContent } from '@instructure/ui-a11y'
import { Avatar, Heading } from '@instructure/ui-elements'
import { Badge } from '@instructure/ui-elements'
import { capitalizeFirstLetter } from '@instructure/ui-utils'
import { Tray } from '@instructure/ui-overlays'
import { Button } from '@instructure/ui-buttons'

import PageHeader from '../PageHeader'

import type { UserType, NotificationType } from '../User'

function LargePageNavigation (
  {navOpen, setNavOpen, user, notifications, pageName} :
  {navOpen: boolean, setNavOpen: any, user: UserType, notifications: Array<NotificationType>, pageName: string}
) {
  return (
    <div style={{position: "fixed", top: "0", left: "0", height: "100%"}}>
      <Navigation
        label="Main navigation"
        toggleLabel={{
          expandedLabel: 'Minimize Navigation',
          minimizedLabel: 'Expand Navigation'
        }}
        minimized={navOpen}
        onMinimized={() => setNavOpen(!navOpen)}
      >
        <Navigation.Item
          icon={<IconEmailLine />}
          label={<ScreenReaderContent>Home</ScreenReaderContent>}
          href="#!home"
          theme={{
            backgroundColor: 'red',
            hoverBackgroundColor: 'blue'
          }}
        />
        <Navigation.Item
          icon={<Avatar name={user.display_name} size="x-small"/>}
          label="Profile"
          href="#!user"
          selected={pageName == 'user'}
        />
        {/* Add back in when notifications added again
        <Navigation.Item
          icon={<Badge count={notifications.length}><IconInboxLine /></Badge>}
          label="Inbox"
          href="#!user/inbox"
          selected={pageName == 'user/inbox'}
        /> */}
      </Navigation>
    </div>
  )
}

function SmallPageNavigation (
  {navOpen, setNavOpen, user, notifications, pageName} :
  {navOpen: boolean, setNavOpen: any, user: UserType, notifications: Array<NotificationType>, pageName: string}
) {
  return (
    <Tray
      label="Navigation"
      open={navOpen}
      onDismiss={() => setNavOpen(!navOpen)}
      size="small">
      <View as="div" margin="xx-small small">
        <Flex>
          <Flex.Item grow shrink>
            <Heading level="h2" margin="x-small xxx-small">Navigation</Heading>
          </Flex.Item>
          <Flex.Item>
            <Button
              variant="icon"
              icon={IconXLine}
              onClick={() => setNavOpen(!navOpen)}
            >
              <ScreenReaderContent>Close</ScreenReaderContent>
            </Button>
          </Flex.Item>
        </Flex>
        <Button
          variant="link"
          size="small"
          href="#!user"
          margin="x-small"
        >
          <Avatar
            name={user.display_name}
            size="x-small"
          />
        </Button>
        {/* Add back in when notifications added again
        <Button fluidWidth icon={<Badge count={notifications.length}><IconInboxLine /></Badge>} href="#!user/inbox" margin="x-small">
          Inbox
        </Button> */}
      </View>
    </Tray>
  )
}


export default function Page (
  {user, notifications, children, pageName, pageHeader} :
  {user: UserType, notifications: Array<NotificationType>, children: React.Node, pageName: string, pageHeader?: React.Node}
) {
  const [navOpen: boolean, setNavOpen] = React.useState(false)

  return (
    <div>
      <Responsive
        match="media"
        query={{
          small: { maxWidth: 600 },
          large: { minWidth: 600}
        }}
      >
        {(props, matches) => {
          if (matches.includes('large')) {
            const marginLeft = navOpen ? '54px' : '84px'
            return <>
              <LargePageNavigation
                navOpen={navOpen}
                setNavOpen={setNavOpen}
                user={user}
                notifications={notifications}
                pageName={pageName}
              />
              <div
                style={
                  {display: "flex", flexDirection: "column", marginLeft, padding: '0.75 rem' }
                }
              >
                <View as="div" margin="medium small none medium">
                  <View as="div" margin="none none medium none">
                    {pageHeader ? pageHeader : <PageHeader pageName={capitalizeFirstLetter(pageName)} />}
                  </View>
                  {children}
                </View>
              </div>
            </>
          } else {
            return <>
              <SmallPageNavigation
                navOpen={navOpen}
                setNavOpen={setNavOpen}
                user={user}
                notifications={notifications}
                pageName={pageName}
              />
              <div
                style={
                  {display: "flex", flexDirection: "column", padding: '0.25 rem' }
                }
              >
                <Flex margin="small none">
                  <Flex.Item>
                    <Button
                      icon={IconHamburgerSolid}
                      variant="icon"
                      onClick={() => setNavOpen(!navOpen)}
                      margin="none small none xx-small"
                    >
                      <ScreenReaderContent>Open Navigation</ScreenReaderContent>
                    </Button>
                  </Flex.Item>
                  <Flex.Item shrink grow>
                    {pageHeader ? pageHeader : <PageHeader pageName={capitalizeFirstLetter(pageName)} size="small"/>}
                  </Flex.Item>
                </Flex>
                {children}
              </div>
            </>
          }
        }}
      </Responsive>
    </div>
  )
}
