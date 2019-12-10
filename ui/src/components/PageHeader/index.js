// @flow

import React from "react";

import { Heading, Link } from "@instructure/ui-elements";
import { Breadcrumb } from "@instructure/ui-breadcrumb";
import { View } from "@instructure/ui-layout";
import { capitalizeFirstLetter } from "@instructure/ui-utils";

import type { BreadCrumbType } from "./type";

function linkFromDisplayName(displayName) {
  return `#!${displayName
    .split(" ")
    .join("")
    .replace(displayName[0], displayName[0].toLowerCase())}`;
}

function displayNameFromPageName(pageName) {
  return pageName
    .split(" ")
    .map(s => capitalizeFirstLetter(s))
    .join(" ");
}

export default function PageHeader({
  pageName,
  breadCrumbs
}: {
  pageName?: string,
  breadCrumbs?: Array<BreadCrumbType>,
  size?: string
}) {
  if (pageName) {
    const displayName = displayNameFromPageName(pageName);
    return (
      <View display="inline-block" margin="medium none">
        <Heading
          level="h1"
          margin="medium none"
          as="a"
          href={linkFromDisplayName(displayName)}
        >
          {displayName}
        </Heading>
      </View>
    );
  } else if (breadCrumbs && breadCrumbs.length > 0) {
    return (
      <View as="div" padding="medium none" borderWidth="none none small none">
        <Breadcrumb size="large" label="Application Navigation">
          {breadCrumbs.map(b => (
            <Breadcrumb.Link key={b.href} href={b.href} icon={b.icon}>
              {b.linkText}
            </Breadcrumb.Link>
          ))}
        </Breadcrumb>
      </View>
    );
  } else {
    return null;
  }
}
