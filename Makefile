.PHONY: install clean css css_inline tidy html archive

# Common variables
SRC_FOLDER=./src
PUBLIC_FOLDER=./public
STYLESHEETS_LOC=$(SRC_FOLDER)/stylesheets
TEMPLATE_LIST=blank commons lords
EMAIL_PLATFORM=mailchimp

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
	@$(NODE_SASS) --output-style compressed --include-path $(PUGIN)/$(STYLESHEETS_LOC) -o $(PUBLIC_FOLDER)/stylesheets $(STYLESHEETS_LOC)
	@$(POSTCSS) -u autoprefixer -r $(PUBLIC_FOLDER)/stylesheets/* --no-map


# Inlines the CSS
css_inline:
	@for template in $(TEMPLATE_LIST); do \
		$(JUICE) --web-resources-images false $(PUBLIC_FOLDER)/$$template.html $(PUBLIC_FOLDER)/$$template-inlined.html ; \
	done

# Removes unused assets from public dir post build
tidy:
	@for template in $(TEMPLATE_LIST); do \
		rm $(PUBLIC_FOLDER)/$$template.html ; \
	done
	@rm -rf $(PUBLIC_FOLDER)/stylesheets

# Archives the email platform templates for upload
archive:
	@mkdir -p $(PUBLIC_FOLDER)/$(EMAIL_PLATFORM)
	@for template in $(TEMPLATE_LIST); do \
		pushd $(PUBLIC_FOLDER) ; \
		zip -r $(EMAIL_PLATFORM)/$$template.zip $$template-inlined.html images ; \
		popd ; \
	done

# Makes HTML templates from pug files
html:
	@mkdir -p $(PUBLIC_FOLDER)
	$(PUG) $(SRC_FOLDER)/templates -P -o $(PUBLIC_FOLDER)

# Copies images into public dir
images:
	@mkdir -p $(PUBLIC_FOLDER)/images
	@cp -r $(SRC_FOLDER)/images $(PUBLIC_FOLDER)

build: clean images css html css_inline tidy archive
