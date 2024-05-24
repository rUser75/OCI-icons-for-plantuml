
# OCI Icons for PlantUML

PlantUML images, sprites, macros, and other includes for Oracle Cloud Infrastructure (OUC) services and resources.
Used to create PlantUML diagrams with OCI components.
All elements are generated from the official [OCI Architecture Diagram Toolkits](https://docs.oracle.com/en-us/iaas/Content/General/Reference/graphicsfordiagrams.htm).
The original png files was resized to fit correct size.

## Table of Contents

<!-- toc -->

- [Getting Started](#getting-started)
  - [Hello World](#hello-world)
- [Examples](#examples)
  - [Basic Usage](#basic-usage)
  - [Raw Images](#raw-images)
  - [Simplified View](#simplified-view)
  - [Sequence Diagrams](#sequence-diagrams)
- [Distribution "Dist" Details](#distribution-dist-details)
- [Advanced Examples](#advanced-examples)
- [Customized Builds](#customized-builds)
- [Contributing](#contributing)
- [License Summary](#license-summary)
- [Acknowledgements](#acknowledgements)

<!-- tocstop -->

## Getting Started

In order to incorporate and use the _OCI Icons for PlantUML_ resources, you must include the library insde you diagram.
You can include the remote repository or you can download library and after use the local copy

To add the library in the PlantUML you must use the directive

<pre><code>!include https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/<b>v1.0<\b>/dist/OCICommon.puml
  
</code></pre>

or this if defining the URL:

<pre><code>!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/<b>v1.0<\b>/dist/
</code></pre>

or if you have already donwloaded the library
```
!include localpath/to/OCICommon.puml
```

Please references the files using a specific version instad of the main branch

After inclusion of the `OCICommon.puml` file, there are two different ways to reference resources:

1. **Use individual include files** - Use one file per service or setting. For example:

   `!include OCIPuml/Compute/BareMetalCompute.puml`

1. **Use category include file** - Single include that contains all services and resources for that category. For example:

   `!include OCIPuml/Compute/all.puml`

All of the services can be found in the `dist/` directory, which includes the service or product categories and the corresponding `puml` files.

For example, including these files from the repository (URL), the includes would look like this:

```
' Define the main location (URL or local file path)
!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/v1.0/dist/
' Include main OCICommon and then resource files
!include OCIPuml/OCICommon.puml
!include OCIPuml/Compute/all.puml
!include OCIPuml/Storage/LocalStorage.puml
```

The name of all objects have the prefix oci_/OCI_ this to be sure that are not overlay with similar object like AWS,AZURE and so

##Hello World
```
@startuml
' Define the main location (URL or local file path)
!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/v1.0/dist
' Include main OCICommon and then resource files
!include OCIPuml/OCICommon.puml
!include OCIPuml/Compute/all.puml

oci_VirtualMachine(one,VirtualMachine,this_is_the_pngImage)
' this is a sprite color,scale,
OCI_VIRTUALMACHINE(blue,1,luca)
'OCI_VIRTUALMACHINE(myname,myname,red,"label",two,"my name",rectangle)

@enduml
```
