# UK Parliament Email Components

Mailchimp templates and components for UK Parliament emails.

## Usage

To use, clone and build this repository with `npm install`.

## Templates

The templates in this repository are designed to be flexible; Mailchimp attributes have been added to make the different components repeatable and editable for ease of email composition, but you may wish to add new templates in time.

In this section:
- [Creating new templates](#creating-new-templates')
- [Available template components](#available-template-components')
- [Creating new template components](#creating-new-template-components')
- [Building templates](#building-templates')

### Creating new templates

To create a new template, you need to simply create the desired file at `src/templates/<filename>.pug` and extend one of:
- **blank.pug**: For generic templates
- **commons.pug**: For House of Commons branding
- **lords.pug**: For House of Lords branding

**N.B.** Don't forget to add the new template to the `TEMPLATE_LIST` variable in the Makefile!

### Available template components
- `components/content-with-image-full-width.pug`: Full width image with text content beneath
- `components/content-with-image-half-width.pug`: Half width image with text content to right-hand side
- `components/content-with-image-third-width.pug`: 1/3 width image with text content to right-hand side
- `components/divider.pug`: Horizontal rule / divider (branded)
- `components/section-title.pug`: Title with horizontal rule / dividers above and below (branded)
- `components/table-of-contents.pug`: A TOC for the top of the email
- `components/third-images.pug`: 3-column image layout with small amount of text beneath
- `components/fourth-images.pug`: 4-column image layout with small amount of text beneath

### Creating new template components

To create a new component, you need to do the following:

1. Create the desired file at `src/components/<filename>.pug`
2. Add an include for it in the blank template at `src/templates/blank.pug`
3. Re-test the template(s) using Litmus (or similar)
4. Update this README
5. Push updated templates to Mailchimp so that users can benefit from the new component
6. Make sure editable fields work in Mailchimp (check mc: attributes if not)

### Building templates

Use `make build` to re-build the email templates.

**N.B** This is already done via a `postinstall` hook for first-time installs.
