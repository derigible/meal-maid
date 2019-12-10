// @flow

import * as React from "react";

import { Flex, View } from "@instructure/ui-layout";
import { Link } from "@instructure/ui-elements";

import { useMedia } from "../../../hooks/index.js";

const large = {
  padding: "small large"
};
const small = {
  padding: "small small"
};

function NavItem({
  href,
  displayName,
  layout
}: {
  href: string,
  displayName: string,
  layout: any
}) {
  return (
    <Link href={`#!${href}`}>
      <View display="inline-block" borderWidth="small" {...layout}>
        {displayName}
      </View>
    </Link>
  );
}

export default function Navigation() {
  const layout = useMedia(
    ["(min-width: 900px)", "(max-width: 900px)"],
    [large, small],
    "large"
  );

  return (
    <View display="inline-block" margin="large none">
      <Flex>
        <Flex.Item>
          <NavItem href="recipes" displayName="Recipes" layout={layout} />
        </Flex.Item>
        <Flex.Item>
          <NavItem href="inventory" displayName="Inventory" layout={layout} />
        </Flex.Item>
        <Flex.Item>
          <NavItem href="planning" displayName="Planning" layout={layout} />
        </Flex.Item>
        <Flex.Item>
          <NavItem href="history" displayName="History" layout={layout} />
        </Flex.Item>
      </Flex>
    </View>
  );
}
