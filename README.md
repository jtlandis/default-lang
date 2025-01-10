# Default-lang Extension For Quarto

Default language extension for Quarto. Sets the default language for unmarked inline code / code blocks.

## Installing

```bash
quarto add jtlandis/default-lang
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

add to the yaml header:

```yaml
filters:
  - default-lang
default-code-lang: r # or python, or whatever
```

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
