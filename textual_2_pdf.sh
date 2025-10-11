#!/bin/zsh

find . -type f -name "*.html" | xargs pandoc -o ./textual_web.pdf --css=./stylesheet.css --pdf-engine=weasyprint
