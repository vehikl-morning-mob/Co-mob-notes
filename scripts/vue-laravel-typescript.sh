#!/bin/bash

echo Provide project name:
read projectName

composer create-project --prefer-dist laravel/laravel $projectName

cd $projectName

npm install typescript ts-loader vue-template-compiler vue-property-decorator jest vue-jest ts-jest @types/jest @vue/test-utils babel-core --save-dev

wget https://gist.githubusercontent.com/vehikl-morning-mob/01845e0ffc3963751968041c1cc32f70/raw/120cc9e4fb4ea5183b7d6570086e38fc12bdc768/tsconfig.json

# modify webpack
sed -i '' 's/\.js/\.ts/g' webpack.mix.js

# change entry point from js to ts
cd resources/js
rm app.js
wget https://gist.githubusercontent.com/vehikl-morning-mob/faf5959628bfb36edeecaed11b92e721/raw/7aa677a39bfa907f3497060cfcfcfc9448b26a64/app.ts

# Changing ExampleComponent from js to ts
cd components/
rm -f ExampleComponent.vue ExampleComponent.vue.d.ts
wget https://gist.githubusercontent.com/vehikl-morning-mob/23ff1ba6e96e72262677a8c9b2ce6127/raw/c30efe83eb55a0e6fe5b5be41944949fc9953bcf/ExampleComponent.vue.d.ts
wget https://gist.githubusercontent.com/vehikl-morning-mob/1a444eb97f9c21344b20f9b0cb78aaa9/raw/47edc817be45345a8a597ee34c73d2c0ad073ebf/ExampleComponent.vue

# Create tests folder and create ExampleComponent test
mkdir __tests__
cd __tests__
wget https://gist.githubusercontent.com/vehikl-morning-mob/1a8b36185ad0d640cd646442f339247a/raw/563cf67a7c48807087d8259b083bd9dc6d15df2c/ExampleComponent.spec.ts

# Go back to the root
cd ../../../..

# Update Package.json for jest
replaceValue=",\"jest\":\{\"moduleFileExtensions\":\[\"js\",\"ts\",\"json\"\],\"transform\":\{\".*\\.ts\$\":\"ts-jest\",\".*\\.vue\$\":\"vue-jest\"\}\}\}"
sed -i '' "\$s/}/${replaceValue}/" package.json

sed -i '' "s/\"scripts\":[[:blank:]]*{/\"scripts\": {\"test\": \"jest\",/" package.json

cd resources/views/
rm -f welcome.blade.php
wget https://gist.githubusercontent.com/vehikl-morning-mob/98bd81a64fede9ab28aa1108cf7ed24a/raw/cc08fd9b767bf0cd4eff0f4cdbf91f1352329c38/welcome.blade.php