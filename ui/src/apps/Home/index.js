// @flow

import * as React from "react";

import WeeklyPlan from "./WeeklyPlan";
import Navigation from "./Navigation";

import type { WeeklyPlanType } from "../../types";

export default function Home({ weeklyPlan }: { weeklyPlan: WeeklyPlanType }) {
  return (
    <>
      <WeeklyPlan weeklyPlan={weeklyPlan} />
      <Navigation />
    </>
  );
}
