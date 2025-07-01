# groovy-wix
A [WiX](https://wixtoolset.org/) based installer for Groovy.
Binaries are available on [JFrog](https://groovy.jfrog.io/artifactory/dist-release-local/groovy-windows-installer/).

## Prerequisites
### Required
* [WiX Toolset](https://github.com/wixtoolset/wix/releases)

### Optional
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/)
  * [HeatWave extension](https://marketplace.visualstudio.com/items?itemName=FireGiant.FireGiantHeatWaveDev17)

Or
* [Jetbrains Rider](https://www.jetbrains.com/rider/)

## Steps for a new release
1. Create the directories _apache-groovy-binary_ and _apache-groovy-docs_ in the project root
1. Unzip the Groovy binary zip into _apache-groovy-binary_, without the root directory in zip
   ```bash
   unzip apache-groovy-binary-*.zip
   mv groovy-*/* apache-groovy-binary/
   ```
1. Unzip the Groovy docs zip into _apache-groovy-docs_, without the root directory in zip
   ```bash
   unzip apache-groovy-docs-*.zip
   mv groovy-*/* apache-groovy-docs/
   ```
1. Replace `x.y.z` with the Groovy version in _groovy-wix.wixproj_
(this can be edited in Visual Studio by editing the _Output name_ on the _Installer_ tab,
and the _Define preprocessor variables_ on the _Build tab in the properties of the groovy-wix WIX project).
The result will be something like
   ```diff
   diff --git a/groovy-wix/groovy-wix.wixproj b/groovy-wix/groovy-wix.wixproj
   index 070304a..8c602d0 100644
   --- a/groovy-wix/groovy-wix.wixproj
   +++ b/groovy-wix/groovy-wix.wixproj
   @@ -3,8 +3,8 @@
   <EnableDefaultCompileItems>false</EnableDefaultCompileItems>
   </PropertyGroup>
   <PropertyGroup>
   -    <OutputName>groovy-x.y.z</OutputName>
   -    <DefineConstants>groovyVersion=x.y.z;binariesSourceFolder=$(SolutionDir)apache-groovy-binary;docsSourceFolder=$(SolutionDir)apache-groovy-docs</DefineConstants>
   +    <OutputName>groovy-5.0.0</OutputName>
   +    <DefineConstants>groovyVersion=5.0.0;binariesSourceFolder=$(SolutionDir)apache-groovy-binary;docsSourceFolder=$(SolutionDir)apache-groovy-docs</DefineConstants>   
        <WixVariables>
        </WixVariables>
        </PropertyGroup>
   ```
1. Build the solution
1. Reset the project by cleaning the solution and running the commands below
   ```bash
   rm -r apache-groovy-binary/* apache-groovy-docs/*
   git checkout groovy-wix/groovy-wix.wixproj groovy-wix/GroovyBinaries.wsx groovy-wix/GroovyDocs.wsx
   ```
