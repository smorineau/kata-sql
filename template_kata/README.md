Example : initializing a new project called great_project


Copy contents of template_kata to the great_project folder

    cp -R /full/path/to/template_kata/ /full/path/to/great_project/

rename files by changing template_package to great_project

    rename 's/template_package/great_project/' *template_package*

search and replace template_package with the actual package name

    sed -i 's/template_package/great_project/g' *