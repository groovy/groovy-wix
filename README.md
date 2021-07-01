# groovy-wix
A [WiX](https://wixtoolset.org/) based installer for Groovy.
Binaries are available on [JFrog](https://groovy.jfrog.io/artifactory/dist-release-local/groovy-windows-installer/).

## Required tools
* [WiX toolset 3.11](https://wixtoolset.org/releases/)
* [Visual Studio 2019](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16)
* [WIX Toolset Visual Studio 2019 Extension](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2019Extension)

## Steps for a new release
1. Create the diectories _apache-groovy-binary_ and _apache-groovy-docs_ in the project root
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
   index 3235a5a..2ded751 100644
   --- a/groovy-wix/groovy-wix.wixproj
   +++ b/groovy-wix/groovy-wix.wixproj
   @@ -6,7 +6,7 @@
        <ProductVersion>3.10</ProductVersion>
        <ProjectGuid>aacf45d5-532f-4ea1-8747-138dee1e93a0</ProjectGuid>
        <SchemaVersion>2.0</SchemaVersion>
   -    <OutputName>groovy-x.y.z</OutputName>
   +    <OutputName>groovy-1.0.0</OutputName>
        <OutputType>Package</OutputType>
      </PropertyGroup>
      <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|x86' ">
   @@ -23,7 +23,7 @@
      <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|x86' ">
        <OutputPath>bin\$(Configuration)\</OutputPath>
        <IntermediateOutputPath>obj\$(Configuration)\</IntermediateOutputPath>
   -    <DefineConstants>groovyVersion=x.y.z;binariesSourceFolder=$(SolutionDir)apache-groovy-binary;docsSourceFolder=$(SolutionDir)apache-groovy-docs</DefineConstants>
   +    <DefineConstants>groovyVersion=1.0.0;binariesSourceFolder=$(SolutionDir)apache-groovy-binary;docsSourceFolder=$(SolutionDir)apache-groovy-docs</DefineConstants>
      </PropertyGroup>
      <ItemGroup>
        <Compile Include="Product.wxs" />
   ```
1. Build the solution
1. Reset the project by cleaning the solution and running the commands below
   ```bash
   rm -r apache-groovy-binary/* apache-groovy-docs/*
   git checkout groovy-wix/groovy-wix.wixproj groovy-wix/GroovyBinaries.wsx groovy-wix/GroovyDocs.wsx
   ```
