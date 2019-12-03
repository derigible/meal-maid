// @flow

import * as React from "react";

import { Flex, View } from "@instructure/ui-layout";
import {
  IconHamburgerSolid,
  IconAssignmentLine,
  IconQuizInstructionsLine,
  IconXLine
} from "@instructure/ui-icons";

import { ScreenReaderContent } from "@instructure/ui-a11y";
import { Avatar, Heading } from "@instructure/ui-elements";

import { Tray } from "@instructure/ui-overlays";
import { Button } from "@instructure/ui-buttons";

import PageHeader from "../PageHeader";

import type { UserType, NotificationType } from "../User";

function SmallPageNavigation({
  navOpen,
  setNavOpen,
  user,
  notifications,
  pageName
}: {
  navOpen: boolean,
  setNavOpen: any,
  user: UserType,
  notifications: Array<NotificationType>,
  pageName: string
}) {
  return (
    <Tray
      label="Navigation"
      open={navOpen}
      onDismiss={() => setNavOpen(!navOpen)}
      size="small"
    >
      <View as="div" margin="xx-small small">
        <Flex>
          <Flex.Item grow shrink>
            <Heading level="h2" margin="x-small xxx-small">
              Navigation
            </Heading>
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
        <Button variant="link" size="small" href="#!user" margin="x-small">
          <Avatar name={user.displayName} size="x-small" />
        </Button>
        {/* Add back in when notifications added again
        <Button fluidWidth icon={<Badge count={notifications.length}><IconInboxLine /></Badge>} href="#!user/inbox" margin="x-small">
          Inbox
        </Button> */}
        <Button
          fluidWidth
          icon={<IconAssignmentLine />}
          href="#!home"
          margin="x-small"
        >
          Weekly Plans
        </Button>
        <Button
          fluidWidth
          icon={<IconQuizInstructionsLine />}
          href="#!recipes"
          margin="x-small"
        >
          Recipes
        </Button>
      </View>
    </Tray>
  );
}

export default function Page({
  user,
  notifications,
  children,
  pageName,
  pageHeader
}: {
  user: UserType,
  notifications: Array<NotificationType>,
  children: React.Node,
  pageName: string,
  pageHeader?: React.Node
}) {
  const [navOpen: boolean, setNavOpen] = React.useState(false);

  return (
    <div>
      <SmallPageNavigation
        navOpen={navOpen}
        setNavOpen={setNavOpen}
        user={user}
        notifications={notifications}
        pageName={pageName}
      />
      <div
        style={{
          display: "flex",
          flexDirection: "column",
          padding: "0.25 rem"
        }}
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
            {pageHeader ? (
              pageHeader
            ) : (
              <PageHeader pageName={pageName} size="small" />
            )}
          </Flex.Item>
        </Flex>
        {children}
      </div>
    </div>
  );
}
