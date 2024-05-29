
# OCI Icons for PlantUML

PlantUML images, sprites, macros, and other includes for Oracle Cloud Infrastructure (OCI) services and resources.
Used to create PlantUML diagrams with OCI components.
All elements are generated from the official [OCI Architecture Diagram Toolkits](https://docs.oracle.com/en-us/iaas/Content/General/Reference/graphicsfordiagrams.htm).
The original png files was resized to fit correct size.

## Table of Contents

<!-- toc -->

- [Getting Started](#getting-started)
  - [Hello World](#hello-world)
- [Usage](#Usage)
- [Examples](#examples)
  - [List of available symbols](OCISymbols.md)
- [License Summary](#license-summary)
- [Acknowledgements](#acknowledgements)

<!-- tocstop -->

## Getting Started

In order to incorporate and use the _OCI Icons for PlantUML_ resources, you must include the library insde you diagram.
You can include the remote repository or you can download library and after use the local copy

To add the library in the PlantUML you must use the directive

<pre><code>!include https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/<b>v1.2</b>/dist/OCICommon.puml
  
</code></pre>

or this if defining the URL:

<pre><code>!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/<b>v1.2</b>/dist/
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

## Hello World
```
@startuml helloWorld
' Define the main location (URL or local file path)
!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/v1.0/dist
' Include main OCICommon and then resource files
!include OCIPuml/OCICommon.puml
!include OCIPuml/Compute/all.puml

oci_VirtualMachine(one,VirtualMachine,this_is_the_pngImage)
' this is a sprite color,scale,alias
OCI_VIRTUALMACHINE(blue,1,virta)
' this is a sprite color,scale,alias,shape (rectangle, node,agent),label
OCI_FUNCTIONS(red,0.5,funct,node,virtualMachine)

funct --> virta
virta --> one

@enduml
```
this is the example

![helloWorld](https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/main/example/helloWorld.png)

# Usage 

Each object has a unique  name and you can use it in many ways.
In [OCISymbols.md](OCISymbols.md) you can find, in the column **PUML macro name** the list of all available names to refers to a specific object.

for example see the below code.

```
@startuml helloWorld
' Define the main location (URL or local file path)
!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/v1.2/dist
' Include main OCICommon and then resource files
!include OCIPuml/OCICommon.puml
!include OCIPuml/Compute/all.puml



component "$oci_VirtualMachineIMG()" as  virt1

file "$oci_VirtualMachineIMG()" as virt2 

oci_VirtualMachine(one,VirtualMachine,this_is_the_pngImage)

' sprite invocation with 5 parameter  (color,scale,alias,shape,description)
OCI_VIRTUALMACHINE(red,0.5,virt3,rectangle,virtualMachine)

' sprite invocation with  parameter  (color,scale,alias)
OCI_VIRTUALMACHINE(blue,2,virtualMachine)

@enduml
```


![usage_01](https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/main/example/usage_01.png)

You can refer to the same object in different ways. You can use one or the other as you like or depending on what you need to do.
If you include the `Groups.puml` file you can use the groups, this **special** object permitt to grouping severals object in inside it .You can the use the   group for  draw VCN, region o put together elements that rappresents  specific services.

```
@startuml
' Define the main location (URL or local file path)
!define OCIPuml https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/v1.2/dist
' Include main OCICommon and then resource files
!include OCIPuml/OCICommon.puml
!include OCIPuml/Compute/all.puml
!include OCIPuml/Groups/all.puml
!include OCIPuml/IdentitySecurity/all.puml


oci_RegionGroup(myregion,myregion){
  oci_VCNGroup(myvcn,myVCN){
     oci_GenericGroup(mygroup,my_group){
        oci_VirtualMachine(myvirt1,webServer,webServer)
        oci_VirtualMachine(myvirt2,ASServer,ASServer)
     }

     OCI_USERGROUPUNISEX(red,1,user)
     
  }
}
user ---> myvirt1 :http_requests
myvirt1 ---> myvirt2
@enduml
```

![usage_02](https://raw.githubusercontent.com/rUser75/OCI-icons-for-plantuml/main/example/usage_02.png)

# Examples 
refers to the directory example [example](example)

# license-summary
 Code is made available under the MIT license in LICENSE-CODE.

# Acknowledgements and references
 
- [PlantUML](http://plantuml.com/index)
- [git plantuml](https://github.com/plantuml)
- [aws-icons-for-plantum](https://github.com/awslabs/aws-icons-for-plantum)
- [Diagram as Code: Create Your Own Sprites library for PlantUML](https://itnext.io/diagram-as-code-create-your-own-sprites-library-for-plantuml-f8cffb83b038)
- [OCI Architecture Diagram Toolkits](https://docs.oracle.com/en-us/iaas/Content/General/Reference/graphicsfordiagrams.htm)


 
