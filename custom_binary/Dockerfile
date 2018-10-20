# Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.
FROM arm64v8/alpine
RUN mkdir -p /usr/lib/dart/bin

ADD ./dart-sdk/bin /usr/lib/dart/bin

ENV DART_SDK /usr/lib/dart
ENV PATH $DART_SDK/bin:$PATH

EXPOSE 8080 8181 5858

CMD []
ENTRYPOINT ["/usr/lib/dart/bin/dart" "--version"]
