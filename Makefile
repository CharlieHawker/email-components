.PHONY: install clean css html css_inline

# Common variables
SRC_FOLDER=./src
PUBLIC_FOLDER=./public
STYLESHEETS_LOC=$(SRC_FOLDER)/stylesheets

# Node modules
NODE_MODULES=./node_modules
PUGIN=$(NODE_MODULES)/parliamentuk-pugin
NODE_SASS=$(PUGIN)/node_modules/.bin/node-sass
POSTCSS=$(PUGIN)/node_modules/.bin/postcss
PUG=$(PUGIN)/node_modules/.bin/pug
JUICE=./node_modules/.bin/juice

# Installs npm packages
install:
	make install -C $(PUGIN)

# Deletes the public folder
clean:
	@rm -rf $(PUBLIC_FOLDER)

# Deletes the public and node modules folder
clean_hard: clean
	@rm -rf $(NODE_MODULES)

# Compiles sass to css
css:
	@mkdir -p $(PUBLIC_FOLDER)/stylesheets
	@$(NODE_SASS) --output-style compressed -o $(PUBLIC_FOLDER)/stylesheets $(STYLESHEETS_LOC)
	@$(NODE_SASS) --output-style compressed -o $(PUBLIC_FOLDER)/stylesheets $(PUGIN)/$(STYLESHEETS_LOC)
	@$(POSTCSS) -u autoprefixer -r $(PUBLIC_FOLDER)/stylesheets/* --no-map

css_inline:
	$(JUICE) $(PUBLIC_FOLDER)/blank.html $(PUBLIC_FOLDER)/blank-inlined.html
	$(JUICE) $(PUBLIC_FOLDER)/master.html $(PUBLIC_FOLDER)/master-inlined.html

html:
	$(PUG) $(SRC_FOLDER)/html -P -o .$(PUBLIC_FOLDER)

images:
	@mkdir -p $(PUBLIC_FOLDER)/images
	@cp -r $(SRC_FOLDER)/images $(PUBLIC_FOLDER)

build: images css html css_inline
