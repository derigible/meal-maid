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

function Navigation({
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
      <View as="div" margin="none small">
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
        <Button
          variant="link"
          size="small"
          href="#!user"
          margin="x-small"
          onClick={() => setNavOpen(!navOpen)}
        >
          <Avatar name={user.displayName} size="x-small" />
        </Button>
        <Button
          fluidWidth
          icon={<IconAssignmentLine />}
          href="#!weeklyPlan"
          onClick={() => setNavOpen(!navOpen)}
          margin="x-small"
        >
          Weekly Plan
        </Button>
        <Button
          fluidWidth
          icon={<IconQuizInstructionsLine />}
          href="#!recipes"
          onClick={() => setNavOpen(!navOpen)}
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
    <View as="div" maxWidth="100rem" margin="auto">
      <Navigation
        navOpen={navOpen}
        setNavOpen={setNavOpen}
        user={user}
        notifications={notifications}
        pageName={pageName}
      />
      <div style={{ margin: "auto", textAlign: "center" }}>
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
    </View>
  );
}
