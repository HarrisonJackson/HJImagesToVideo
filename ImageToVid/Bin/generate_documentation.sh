#!/bin/sh

#  Created by Carl Hill-Popper on 2/20/12.

Bin/appledoc \
--project-name "$PROJECT" \
--output "$PROJECT_DIR"/Documentation \
--logformat xcode \
--exit-threshold 2 \
--keep-intermediate-files \
--keep-undocumented-members \
--keep-undocumented-objects \
--ignore Bin \
--ignore Documentation \
--ignore Lib \
--ignore .m \
--ignore .mm \
--ignore _private.h \
"$PROJECT_DIR"
