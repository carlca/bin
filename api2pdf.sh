#!/bin/zsh

find . -type f -name "*.html" | xargs pandoc -o ./bw_api_docs_532.pdf --css=./stylesheet.css --pdf-engine=weasyprint
