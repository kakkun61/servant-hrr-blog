{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module ServantHrr.Data.Relation.Book where

import           ServantHrr.DataSource (defineTable)

$(defineTable "book")
