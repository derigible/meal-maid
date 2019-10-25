// @flow

import React from 'react'
import { gql } from "apollo-boost";
import { useQuery } from '@apollo/react-hooks'

import { Flex, View } from '@instructure/ui-layout'
import { Button } from '@instructure/ui-buttons'
import { IconTableLine, IconLaunchLine, IconQuizInstructionsLine } from '@instructure/ui-icons'
import { ScreenReaderContent } from '@instructure/ui-a11y'
import { Billboard } from '@instructure/ui-billboard'
import { Tooltip } from '@instructure/ui-tooltip'
import { Spinner } from '@instructure/ui-elements'
import { capitalizeFirstLetter } from '@instructure/ui-utils'

import StandardSortableTable from '../../components/StandardSortableTable'

function Card ({recipe}) {
  return (
    <View
      as="div"
      width="20rem"
      borderWidth="small"
      borderRadius="medium"
      shadow="above"
      display="inline-block"
      margin="medium"
    >
      <Billboard
        message={capitalizeFirstLetter(recipe.title)}
        size="large"
        href={`#!recipes/${recipe.id}`}
        hero={(size) => <IconQuizInstructionsLine size={size} />}
      />
    </View>
  )
}

function CardRecipes({recipes = []}) {
  return (
    <>
      {
        recipes.map(r => <Card key={r.id} recipe={r} />)
      }
    </>
  )
}

function TableRecipes({recipes = []}) {
  return (
    <StandardSortableTable
      caption="Top rated movies"
      headers={[
        {
          id: 'title',
          text: 'Title'
        },
        {
          id: 'time',
          text: 'Time'
        },
        {
          id: 'rating',
          text: 'Rating',
          renderCell: (rating) => rating.toFixed(1)
        },
        {
          id: 'id',
          text: 'More',
          renderCell: (id) =>(<Button variant="link" href={`#!recipes/${id}`}>More</Button>) // eslint-disable-line react/display-name
        }
      ]}
      rows={recipes}
    />
  )
}

function ToggleButton (
  {type, inverse, toggle, icon} :
  {type: string, inverse: boolean, toggle: any,  icon: any}
) {
  return (
    <View
      display="inline-block"
      background={inverse ? 'inverse' : null}
      padding="x-small"
    >
      <Tooltip
        color="default"
        renderTip={`Use ${type} Layout`}
        on="hover"
      >
        <Button
          icon={icon}
          variant={inverse ? 'icon-inverse' : 'icon'}
          onClick={() => toggle(!inverse)}
        >
          <ScreenReaderContent>{`Use ${type} Layout`}</ScreenReaderContent>
        </Button>
      </Tooltip>
    </View>
  )
}

const recipesQuery = gql`
  {
    recipes {
      title
      time
      rating
      id
    }
  }
`
export default function Recipes() {
  const [isTable, setIsTable] = React.useState(false)

  const { loading, error, data } = useQuery(recipesQuery);

  if (loading) return <Spinner renderTitle="Loading" size="large" margin="0 0 0 medium" />;
  if (error){
    if (new RegExp('Received status code 401').test(error.toString())) {
      setTimeout(() => window.location = '/auth/identity', 1000)
      return <p>User not authenticated. Being redirected to login in 1 second...</p>;
    }
    return <p>Something has gone wrong. Reload the page, clear cookies and cache, and try again.</p>
  }

  return (
    <>
      <Flex>
        <Flex.Item>
          <ToggleButton type="Card" inverse={!isTable} toggle={() => setIsTable(false)} icon={IconLaunchLine} />
          <ToggleButton type="Table" inverse={isTable} toggle={() => setIsTable(true)} icon={IconTableLine} />
        </Flex.Item>
      </Flex>
      {isTable ? <TableRecipes recipes={data.recipes} /> : <CardRecipes recipes={data.recipes} />}
    </>
  )
}
