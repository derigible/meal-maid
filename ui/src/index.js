// @flow

import * as React from "react";
import ReactDOM from "react-dom";
import theme from "@instructure/canvas-theme";
import ApolloClient, { gql } from "apollo-boost";
import { ApolloProvider, useQuery } from "@apollo/react-hooks";

import { Spinner } from "@instructure/ui-elements";

import Page from "./components/Page";

import configureRouter from "./router";

theme.use();

const mountPoint = document.getElementById("app");

const router = configureRouter();

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(";");
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) === " ") c = c.substring(1, c.length);
    if (c.indexOf(nameEQ) === 0)
      return decodeURIComponent(c.substring(nameEQ.length, c.length));
  }
  return null;
}

const client = new ApolloClient({
  request: operation => {
    operation.setContext({
      headers: {
        "X-CSRF-TOKEN": readCookie("X-CSRF-Token")
      }
    });
  }
});

const notifications = [];

const initialQuery = gql`
  {
    user {
      displayName
      email
      preferredName
    }
    currentWeeklyPlan {
      mondayMorning {
        id
        title
      }
      mondayMidday {
        id
        title
      }
      mondayEvening {
        id
        title
      }
      tuesdayMorning {
        id
        title
      }
      tuesdayMidday {
        id
        title
      }
      tuesdayEvening {
        id
        title
      }
      wednesdayMorning {
        id
        title
      }
      wednesdayMidday {
        id
        title
      }
      wednesdayEvening {
        id
        title
      }
      thursdayMorning {
        id
        title
      }
      thursdayMidday {
        id
        title
      }
      thursdayEvening {
        id
        title
      }
      fridayMorning {
        id
        title
      }
      fridayMidday {
        id
        title
      }
      fridayEvening {
        id
        title
      }
      saturdayMorning {
        id
        title
      }
      saturdayMidday {
        id
        title
      }
      saturdayEvening {
        id
        title
      }
      sundayMorning {
        id
        title
      }
      sundayMidday {
        id
        title
      }
      sundayEvening {
        id
        title
      }
    }
  }
`;

function LoginCheck({ View, pageName, params }) {
  const { loading, error, data } = useQuery(initialQuery);

  if (loading)
    return <Spinner renderTitle="Loading" size="large" margin="0 0 0 medium" />;
  if (error) {
    if (new RegExp("Received status code 401").test(error.toString())) {
      setTimeout(() => (window.location = "/auth/identity"), 1000);
      return (
        <p>User not authenitcated. Being redirected to login in 1 second...</p>
      );
    }
    return (
      <p>
        Something has gone wrong. Reload the page, clear cookies and cache, and
        try again.
      </p>
    );
  }

  return (
    <Page user={data.user} notifications={notifications} pageName={pageName}>
      <View weeklyPlan={data.currentWeeklyPlan} {...params} />
    </Page>
  );
}

if (mountPoint !== null) {
  router
    .on("route", async (_, routing) => {
      const { view, pageName, params = {} } = await routing;

      ReactDOM.render(
        <ApolloProvider client={client}>
          <LoginCheck View={view} params={params} pageName={pageName} />
        </ApolloProvider>,
        mountPoint
      );
    })
    .start();
}
