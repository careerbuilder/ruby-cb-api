cb-api
================

A gem that's going to house our internal API interactions.


TODO
==================
1. Error handling
2. Figure out base CbApi internactions with child classes
	2.1 CbApi should handle errors, and setting standard fields (response time, errors, etc)
	2.2 CbApi should extract the base fields from the json packet (meaning sub classes don't have to parse them)