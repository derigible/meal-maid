// @flow

import * as React from "react";
import { gql } from "apollo-boost";
import { useQuery } from "@apollo/react-hooks";

import { View } from "@instructure/ui-layout";
import { Heading } from "@instructure/ui-heading";
import { Spinner } from "@instructure/ui-elements";
import type { RecipeType } from "../../../types";

const recipeQuery = gql`
  query Recipe($id: ID!) {
    recipes(id: $id) {
      title
      time
      rating
      directions
      notes
    }
  }
`;

export default function Recipe({ id }: { id: string }) {
  const { loading, error, data } = useQuery(recipeQuery, {
    variables: { id }
  });

  if (loading)
    return <Spinner renderTitle="Loading" size="large" margin="0 0 0 medium" />;
  if (error) {
    if (new RegExp("Received status code 401").test(error.toString())) {
      setTimeout(() => (window.location = "/auth/identity"), 1000);
      return (
        <p>User not authenticated. Being redirected to login in 1 second...</p>
      );
    }
    return (
      <p>
        Something has gone wrong. Reload the page, clear cookies and cache, and
        try again.
      </p>
    );
  }

  const recipe = data.recipes[0];

  return (
    <View display="block">
      <Heading>{recipe.title}</Heading>
      <p>{recipe.rating}</p>
      <p>{recipe.time}</p>
      <p>{recipe.directions}</p>
      <p>{recipe.notes}</p>
    </View>
  );
}
