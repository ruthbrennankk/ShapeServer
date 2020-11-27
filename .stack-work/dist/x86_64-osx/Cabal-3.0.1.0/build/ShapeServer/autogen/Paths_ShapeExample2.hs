{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_ShapeExample2 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/bin"
libdir     = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/lib/x86_64-osx-ghc-8.8.4/ShapeExample2-0.1.0.0-4oA2sY2TKdK13KsOn5P6kA-ShapeServer"
dynlibdir  = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/lib/x86_64-osx-ghc-8.8.4"
datadir    = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/share/x86_64-osx-ghc-8.8.4/ShapeExample2-0.1.0.0"
libexecdir = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/libexec/x86_64-osx-ghc-8.8.4/ShapeExample2-0.1.0.0"
sysconfdir = "/Users/ruthbrennan/Documents/4th Year/Functional/ShapeServer/.stack-work/install/x86_64-osx/c98a0732b9450d8fd8a8335ad01a95c49caa41605e4a8e1a430c34e055238513/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ShapeExample2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ShapeExample2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ShapeExample2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ShapeExample2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ShapeExample2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ShapeExample2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
