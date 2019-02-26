module ServantHrr.Data.Books
  ( Result
  , Record (..)
  ) where

import           Data.Aeson.TH                     (defaultOptions, deriveJSON)
import           Data.Functor.ProductIsomorphic.TH (defineProductConstructor)
import           Data.HashMap.Strict               (HashMap)
import           Database.HDBC                     (SqlValue)
import           Database.HDBC.Schema.PostgreSQL   ()
import           Database.Record.FromSql           (FromSql)
import           GHC.Generics                      (Generic)

import           ServantHrr.Data.Common            (Name)

type Result = HashMap String Record

data Record =
  Record
    { name   :: Name
    , auther :: Name
    }
  deriving (Show, Read, Generic)

$(deriveJSON defaultOptions ''Record)

$(defineProductConstructor ''Record)

instance FromSql SqlValue Record
