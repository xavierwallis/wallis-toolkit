

from random import choice
from typing import Any, Callable, List


class list( list ):
    
    def map( self, function: Callable ):
        return list( map( function, self ) )


    def filter( self, function: Callable ):
        return list( filter( function, self ) )

    def to_list( self ) -> List:
        return [ *self ]

    def random( self ) -> Any:
        return choice( self )

    def top( self, count: int | None = None ) -> Any:
        return self[ :count ] if count else self[ 0 ]

    def bottom( self, count: int | None = None ) -> Any:
        return self[ -count: ] if count else self[ -1 ]
