{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Version1 where

import Control.Monad.IO.Class  (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH

import Prelude hiding (id)

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|

Person
    name      String
    Primary   name
    deriving  Show

BlogPost
    title     String
    author    String
    Foreign   Person blogPostAuthor author ! ON DELETE CASCADE
    deriving  Show
|]
