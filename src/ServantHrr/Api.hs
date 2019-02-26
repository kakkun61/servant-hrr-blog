module ServantHrr.Api
  ( Api
  , Index
  , Books
  , Book
  ) where

import qualified Data.ByteString.Lazy   as BSL
import           Data.Text              (Text)
import qualified Data.Text.Encoding     as Text
import           Network.HTTP.Media     ((//), (/:))
import           Servant                ((:<|>), (:>), Accept (contentType), Capture, Get, JSON,
                                         MimeRender (mimeRender))

import qualified ServantHrr.Data.Book   as Book
import qualified ServantHrr.Data.Books  as Books
import           ServantHrr.Data.Common (BookId)


type Api =
  Index :<|>
  Books :<|>
  Book

type Index =
  Get '[HTML] Text

type Books =
  "books" :> Get '[JSON] Books.Result

type Book =
  "book" :> Capture "book id" BookId :> Get '[JSON] Book.Result

data HTML

instance Accept HTML where
  contentType _ = "text" // "html" /: ("charset", "utf-8")

instance MimeRender HTML Text where
  mimeRender _ = BSL.fromStrict . Text.encodeUtf8
