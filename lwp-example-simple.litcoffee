
# Lurch Web Platform, Simple Example Application

## Overview

This source code file defines a very simple application built on the
[Lurch Web Platform](https://github.com/lurchmath/lurch) (LWP).
Consider this the "hello world") of the LWP.  Once you understand this
simple example, feel free to browse some of the other examples in
[the Lurch Project's GitHub space](https://github.com/lurchmath).

[See a live version of the result
here.](https://lurchmath.github.io/lwp-example-simple/)

Two files make up this example.  This one is the more important of the two.
The other is the [index.html](index.html) file, which just loads various
scripts, includin the LWP and this file, among others.

To make your own app, you can duplicate these same two files, and customize
them to the needs of your app.  You may need a
[simple build process](gulpfile.litcoffee) to compile
[CoffeeScript](http://www.coffeescript.org) source like this into
JavaScript, or you can just write in JavaScript in the first place.

Now, the code:

## Set the app name

The LWP provides a function to set the app name, for in the browser's/tab's
title bar.  Call it like so:

    setAppName 'ExampleApp'

## Add a help menu item

We want the app itself to link to this documented source code file, so that
users who stumble upon the app can easily find its documentation.

    addHelpMenuSourceCodeLink \
        'lwp-example-simple/blob/master/lwp-example-simple.litcoffee'

We also change the Help/About menu item to be specific to this demo app.

    window.helpAboutText =
        '<p>See the fully documented <a target="top"
        href="https://github.com/lurchmath/lwp-example-simple/blob/master/lwp-example-simple.litcoffee"
        >source code for this demo app</a>.</p>'

## Define one group type

In the LWP, "groups" are the way users mark up a document to give it some
meaning.  They are shown in the UI as bubbles around the marked text.

We assign to a global variable the array of group types we'd like to have in
this application.  The LWP setup process looks for this global variable and,
if it exists, uses its settings in place of the simple defaults.

In this app, we will make just one group type.  It shows up as a button on
the app's toolbar with an icon that looks like two brackets, `[ ]`, because
such an icon will be generated from the `imageHTML` attribute provided
below.  The open and close variants are used in the document to delimit
group boundaries.

    window.groupTypes = [
        name : 'reporter'
        text : 'Simple Event Reporter'
        imageHTML : '[ ]'
        openImageHTML : '['
        closeImageHTML : ']'

The `tagContents` function is called on a group whenever that group is about
to have its bubble drawn, and the result is placed in the bubble tag.  This
function should be fast to compute, since it will be run often.  Usually it
just reports the (stored) results of previously-executed computations.

In this app, bubble tags are very simple:  They report how many characters
are in the group, just as an example.

        tagContents : ( group ) ->
            "#{group.contentAsText()?.length} characters"

The `contentsChanged` function is called on a group whenever that group just
had its contents changed.  The `firstTime` parameter is true when the group
was just constructed, and false every time thereafter; if an app needs to do
any particular initialization of newly constructed groups, it can check the
`firstTime` parameter and respond accordingly.

In this simple app, we just write to the browser console a notification that
the group's contents have changed.  Open your browser console to see
notifications stream by as you type text inside a group.

        contentsChanged : ( group, firstTime ) ->
            console.log 'This group just changed:', group.contentAsText()

The `deleted` function is called on a group immediately after it has been
removed from the document (for example, by the user deleting one or both of
its endpoints).  The group does not exist in the document at the time of
this function call.  Any finalization that may need to be done could be
placed in this function.  Because it is run in the UI thread, it should be
relatively fast.

In this simple app, we just write to the browser console a notification that
the group was deleted.  Open your browser console to see notifications
appear whenever you delete a group.

        deleted : ( group ) ->
            console.log 'You deleted this group:', group
    ]
