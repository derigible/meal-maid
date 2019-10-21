// @flow

import * as React from 'react'

import { Button } from '@instructure/ui-buttons'
import { View } from '@instructure/ui-layout'
import { Text } from '@instructure/ui-text'
import { IconAddLine, IconQuizInstructionsLine } from '@instructure/ui-icons'
import type { RecipeType } from '../../../../types'

export default function TimeSlot ({recipe, isPast} : {recipe?: RecipeType, isPast: boolean}) {
  const handleUpdateRecipe = () => {}
  return (
    <View display="block">
      {
        recipe
        ? (
          <Button
            icon={IconQuizInstructionsLine}
            variant="link"
            margin="x-small"
            onClick={isPast ? null : handleUpdateRecipe}
            href={isPast ? `#!/recipe/${recipe.id}` : null}
          >
            {recipe.title}
          </Button>
        )
        : (
          isPast
            ? <View><Text color="secondary">--</Text></View>
            : <Button icon={IconAddLine} variant="link" margin="x-small">Add Recipe</Button>
        )
      }
    </View>
  )
}
