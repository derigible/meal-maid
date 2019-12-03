// @flow

import React from "react";

import { Button } from "@instructure/ui-buttons";
import { Grid } from "@instructure/ui-layout";
import { IconSaveLine } from "@instructure/ui-icons";

import StandardEdit from "../StandardEdit";

export type UserType = {
  displayName: string,
  email: string,
  preferredName: string
};
type NotificationData = {
  type?: string,
  details: string
};

export type NotificationType = {
  data: NotificationData,
  id: string,
  read: boolean,
  created_at: string,
  updated_at: string
};

type ComponentActionType = {
  type: string,
  payload: string
};

function reducer(state: UserType, action: ComponentActionType) {
  switch (action.type) {
    case "displayName":
      return { ...state, displayName: action.payload };
    case "email":
      return { ...state, email: action.payload };
    case "preferredName":
      return { ...state, preferredName: action.payload };
    default:
      throw new Error();
  }
}

export default function User({ user }: { user: UserType }) {
  const [userObj: UserType, setUserChanges] = React.useReducer(reducer, user);
  const [userChanged: boolean, setUserChanged] = React.useState(false);

  return (
    <>
      <Grid>
        <Grid.Row>
          <Grid.Col>
            <StandardEdit
              label="Display Name"
              value={userObj.displayName}
              onChange={e => {
                setUserChanged(true);
                setUserChanges({
                  type: "displayName",
                  payload: e.target.value
                });
              }}
            />
          </Grid.Col>
          <Grid.Col>
            <StandardEdit
              label="Preferred Name"
              value={userObj.preferredName}
              onChange={e => {
                setUserChanged(true);
                setUserChanges({
                  type: "preferredName",
                  payload: e.target.value
                });
              }}
            />
          </Grid.Col>
        </Grid.Row>
        <Grid.Row>
          <Grid.Col>
            <StandardEdit
              label="Email"
              value={userObj.email}
              onChange={e => {
                setUserChanged(true);
                setUserChanges({ type: "email", payload: e.target.value });
              }}
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
  );
}
