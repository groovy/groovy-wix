# groovy-wix

A [WiX](https://wixtoolset.org/) based installer for Groovy.
Binaries are available on [JFrog](https://groovy.jfrog.io/artifactory/dist-release-local/groovy-windows-installer/).

## Prerequisites

### Required

* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/)
* [WiX Toolset](https://github.com/wixtoolset/wix/releases)

### Optional

* [WiX v3 extension](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2022Extension)
* [HeatWave extension](https://marketplace.visualstudio.com/items?itemName=FireGiant.FireGiantHeatWaveDev17)
* [Jetbrains Rider](https://www.jetbrains.com/rider/)

## Steps for a new release

1. Run the commands below

   ```powershell
   New-Item -Path "apache-groovy-binary" -ItemType Directory
   Expand-Archive -Path "apache-groovy-binary-*.zip" -DestinationPath .
   Move-Item -Path "groovy-*\*" -Destination "apache-groovy-binary"

   New-Item -Path "apache-groovy-docs" -ItemType Directory
   Expand-Archive -Path "apache-groovy-docs-*.zip" -DestinationPath .
   Move-Item -Path "groovy-*\*" -Destination "apache-groovy-docs"
   ```

2. Replace `x.y.z` with the Groovy version in _groovy-wix.wixproj_
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

3. Build the solution (`& "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" groovy-wix.slnx /t:Build /p:Configuration=Release /p:Platform=x86`)
4. Upload the new installer to [Groovy JFrog](https://groovy.jfrog.io/ui/repos/tree/General/dist-release-local/groovy-windows-installer). The MSI should be put in a new directory, with the name of the release version.

## Cleanup

Reset the project by cleaning the solution (`& "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" msbuild groovy-wix.slnx /t:Clean /p:Configuration=Release /p:Platform=x86`) and running the commands below

```powershell
Remove-Item -Path "apache-groovy-binary", "apache-groovy-docs" -Recurse -Force
git checkout groovy-wix/groovy-wix.wixproj groovy-wix/GroovyBinaries.wsx groovy-wix/GroovyDocs.wsx
```
