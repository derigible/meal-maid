// @flow

import * as React from "react";

import { Flex, View } from "@instructure/ui-layout";
import { Text } from "@instructure/ui-text";
import { capitalizeFirstLetter } from "@instructure/ui-utils";

import { useMedia } from "../../../hooks/index.js";

import TimeSlot from "./TimeSlot";

const rowLayout = {
  direction: "row",
  margin: "none small none none"
};
const columnLayout = {
  direction: "column",
  margin: "none small none none"
};

import type { WeeklyPlanType } from "../../../types";

const dayOfWeekNumber = new Date().getDay();
const days = [
  "sunday",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday"
];

export default function WeeklyPlan({
  weeklyPlan = {}
}: {
  weeklyPlan: WeeklyPlanType
}) {
  const layout = useMedia(
    ["(min-width: 900px)", "(max-width: 900px)"],
    [rowLayout, columnLayout],
    "row"
  );

  return (
    <View
      as="div"
      maxWidth="80rem"
      margin={layout.direction === "row" ? null : "auto"}
    >
      <Flex {...layout} justifyItems="space-between">
        {days.map(d => {
          const dayIndex = days.indexOf(d);
          const isToday = dayOfWeekNumber === dayIndex;
          const isPast = dayIndex < dayOfWeekNumber;
          let color = "primary";
          if (isPast) {
            color = "secondary";
          }
          if (isToday) {
            color = "alert";
          }
          return (
            <View
              as="div"
              shadow={isToday ? "topmost" : null}
              padding={isToday ? "small" : null}
              key={d}
            >
              <Flex.Item shrink grow>
                <View as="div" margin="x-small">
                  <Text color={color}>{capitalizeFirstLetter(d)}</Text>
                </View>
                <TimeSlot isPast={isPast} recipe={weeklyPlan[`${d}Morning`]} />
                <TimeSlot isPast={isPast} recipe={weeklyPlan[`${d}Midday`]} />
                <TimeSlot isPast={isPast} recipe={weeklyPlan[`${d}Evening`]} />
              </Flex.Item>
            </View>
          );
        })}
      </Flex>
    </View>
  );
}
