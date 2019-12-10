// @flow

import Router from "middle-router";

import Home from "./";

const router = Router().use("/", ({ resolve }) => {
  resolve({ view: Home, pageName: "Weekly Plan" });
});

export default router;
