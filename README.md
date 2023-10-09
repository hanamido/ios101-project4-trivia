# Project 4 - *Trivia*

Submitted by: **Hanami Do**

**Trivia** is an app that allows users to play Trivia, with questions retrieved from the Open Trivia Database API. Users can see their overall score after submitting all questions, and also see current progress and get immediate feedback after each question. Users can also reset the game with a new set of questions if they choose to do so. 

Time spent: **10** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view and answer at least 5 trivia questions.
- [x] App retrieves question data from the Open Trivia Database API.
- [x] Fetch a different set of questions if the user indicates they would like to reset the game.
- [x] Users can see score after submitting all questions.
- [x] True or False questions only have two options.


The following **optional** features are implemented:

  
- [x] Allow the user to choose a specific category of questions.
- [x] Provide the user feedback on whether each question was correct before navigating to the next.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

[![IOS101 Project 4 - Trivia (Video Demonstration)](https://markdown-videos-api.jorgenkh.no/url?url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D7xNZJOMhCXM)](https://www.youtube.com/watch?v=7xNZJOMhCXM)

## Notes

The only difficulties I had when developing this was figuring out how to connect the API response to the UI, and also how to display a different screen for the categories (as part of the stretch feature). I wasn't sure how to do this on the page without the UI looking cluttered, so I made a new page for the categories. I also struggled a bit with trying to get the quotation marks and other special characters displayed when they are in the quiz question or answers. I figured out a workaround but I'm still trying to figure out how to get it to load faster without displaying the initial values (of 'question' and 'button'). 

## License

    Copyright [2023] [Hanami Do]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
