// @flow

import Router from "middle-router";

import Recipes from "./";
import Recipe from "./Recipe";

const router = Router()
  .use("/", ({ resolve }) => {
    resolve({ view: Recipes, pageName: "recipes" });
  })
  .use("/:id", ({ params, resolve }) => {
    resolve({ view: Recipe, pageName: "recipes", params });
  });

export default router;
