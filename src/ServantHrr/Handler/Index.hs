module ServantHrr.Handler.Index
  ( handler
  ) where

import           Data.Text              (Text)

import           ServantHrr.Data.Common (Handler)

handler :: Handler Text
handler = pure "<html><body><a href='/books'>books"
