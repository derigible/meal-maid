export type RecipeType = {
  title: string,
  id: string
}

export type WeeklyPlanType = {
  mondayMorning: RecipeType,
  mondayMidday : RecipeType,
  mondayEvening : RecipeType,
  tuesdayMorning : RecipeType,
  tuesdayMidday : RecipeType,
  tuesdayEvening : RecipeType,
  wednesdayMorning : RecipeType,
  wednesdayMidday : RecipeType,
  wednesdayEvening : RecipeType,
  thursdayMorning : RecipeType,
  thursdayMidday : RecipeType,
  thursdayEvening : RecipeType,
  fridayMorning : RecipeType,
  fridayMidday : RecipeType,
  fridayEvening : RecipeType,
  saturdayMorning : RecipeType,
  saturdayMidday : RecipeType,
  saturdayEvening : RecipeType,
  sundayMorning : RecipeType,
  sundayMidday : RecipeType,
  sundayEvening : RecipeType,
}
