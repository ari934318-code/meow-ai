import 'a2_exam_models.dart';

const List<A2ExamQuestion> a2ExamQuestions = [
  // ============================================================
  // VOCABULARY
  // ============================================================

  A2ExamQuestion(
    question: 'What does "appointment" mean?',
    options: [
      'A planned meeting at a specific time',
      'A type of medicine',
      'A school subject',
      'A place to eat',
    ],
    correctIndex: 0,
    explanation: 'An appointment is a planned meeting, usually at a specific time.',
  ),

  A2ExamQuestion(
    question: 'Which word means "a person you work with"?',
    options: [
      'Neighbor',
      'Colleague',
      'Customer',
      'Relative',
    ],
    correctIndex: 1,
    explanation: 'A colleague is someone you work with.',
  ),

  A2ExamQuestion(
    question: 'If something is "crowded", it has...',
    options: [
      'Very few people',
      'No people',
      'Many people',
      'Only children',
    ],
    correctIndex: 2,
    explanation: 'Crowded means that there are many people in a place.',
  ),

  A2ExamQuestion(
    question: 'Where can you usually buy medicine?',
    options: [
      'Pharmacy',
      'Museum',
      'Station',
      'Theater',
    ],
    correctIndex: 0,
    explanation: 'A pharmacy is a place where you can buy medicine.',
  ),

  A2ExamQuestion(
    question: 'What does "refund" mean?',
    options: [
      'A new product',
      'Money returned to you',
      'A discount card',
      'A delivery service',
    ],
    correctIndex: 1,
    explanation: 'A refund is money returned to you after a purchase.',
  ),

  A2ExamQuestion(
    question: 'Which word is related to weather?',
    options: [
      'Forecast',
      'Salary',
      'Password',
      'Homework',
    ],
    correctIndex: 0,
    explanation: 'A forecast tells you what the weather is expected to be like.',
  ),

  A2ExamQuestion(
    question: 'What does "borrow" mean?',
    options: [
      'To give something forever',
      'To take something and return it later',
      'To buy something cheaply',
      'To break something',
    ],
    correctIndex: 1,
    explanation: 'Borrow means to take something temporarily and return it later.',
  ),

  A2ExamQuestion(
    question: 'Which word means "not working correctly"?',
    options: [
      'Healthy',
      'Broken',
      'Friendly',
      'Useful',
    ],
    correctIndex: 1,
    explanation: 'Broken means something is damaged or does not work correctly.',
  ),

  A2ExamQuestion(
    question: 'What is a "neighborhood"?',
    options: [
      'A type of food',
      'An area where people live',
      'A school exam',
      'A weather condition',
    ],
    correctIndex: 1,
    explanation: 'A neighborhood is an area where people live.',
  ),

  A2ExamQuestion(
    question: 'What does "relax" mean?',
    options: [
      'To rest and become less stressed',
      'To work harder',
      'To run quickly',
      'To complain',
    ],
    correctIndex: 0,
    explanation: 'Relax means to rest and become calmer or less stressed.',
  ),

  // ============================================================
  // GRAMMAR
  // ============================================================

  A2ExamQuestion(
    question: 'She usually ___ to work at 8 o’clock.',
    options: [
      'go',
      'goes',
      'is going',
      'going',
    ],
    correctIndex: 1,
    explanation: 'Use the present simple for routines. With "she", use "goes".',
  ),

  A2ExamQuestion(
    question: 'Look! The children ___ in the garden.',
    options: [
      'play',
      'plays',
      'are playing',
      'played',
    ],
    correctIndex: 2,
    explanation: 'Use the present continuous for something happening now.',
  ),

  A2ExamQuestion(
    question: 'I ___ my homework yesterday.',
    options: [
      'finish',
      'finished',
      'am finishing',
      'will finish',
    ],
    correctIndex: 1,
    explanation: '"Yesterday" refers to the past, so use the past simple.',
  ),

  A2ExamQuestion(
    question: 'We ___ visit our grandparents tomorrow.',
    options: [
      'are going to',
      'was',
      'did',
      'have',
    ],
    correctIndex: 0,
    explanation: 'Use "be going to" for future plans.',
  ),

  A2ExamQuestion(
    question: 'You ___ drink more water when you are sick.',
    options: [
      'should',
      'should to',
      'are should',
      'shoulds',
    ],
    correctIndex: 0,
    explanation: 'Use "should + base verb" to give advice.',
  ),

  A2ExamQuestion(
    question: 'There ___ two supermarkets near my house.',
    options: [
      'is',
      'are',
      'be',
      'was',
    ],
    correctIndex: 1,
    explanation: 'Use "there are" with plural nouns.',
  ),

  A2ExamQuestion(
    question: 'I don’t have ___ money with me.',
    options: [
      'some',
      'any',
      'many',
      'a',
    ],
    correctIndex: 1,
    explanation: 'Use "any" in negative sentences with uncountable nouns like money.',
  ),

  A2ExamQuestion(
    question: 'How ___ apples do you need?',
    options: [
      'much',
      'many',
      'any',
      'some',
    ],
    correctIndex: 1,
    explanation: 'Apples are countable, so use "how many".',
  ),

  A2ExamQuestion(
    question: 'My brother is ___ than me.',
    options: [
      'tall',
      'taller',
      'more tall',
      'tallest',
    ],
    correctIndex: 1,
    explanation: 'Use the comparative form "taller" to compare two people.',
  ),

  A2ExamQuestion(
    question: 'I enjoy ___ music in my free time.',
    options: [
      'listen',
      'to listen',
      'listening to',
      'listened',
    ],
    correctIndex: 2,
    explanation: 'After "enjoy", use a verb ending in -ing.',
  ),

  // ============================================================
  // FILL IN THE BLANK
  // ============================================================

  A2ExamQuestion(
    question: 'My mother ___ dinner every evening.',
    options: [
      'cook',
      'cooks',
      'cooking',
      'cooked',
    ],
    correctIndex: 1,
    explanation: 'This is a routine, so use present simple. "My mother" takes "cooks".',
  ),

  A2ExamQuestion(
    question: 'They ___ watching a movie right now.',
    options: [
      'is',
      'are',
      'was',
      'be',
    ],
    correctIndex: 1,
    explanation: 'The subject "they" takes "are" in the present continuous.',
  ),

  A2ExamQuestion(
    question: 'We ___ to the beach last weekend.',
    options: [
      'go',
      'goes',
      'went',
      'going',
    ],
    correctIndex: 2,
    explanation: '"Last weekend" refers to the past. The past form of "go" is "went".',
  ),

  A2ExamQuestion(
    question: 'I think it ___ rain later.',
    options: [
      'will',
      'was',
      'did',
      'has',
    ],
    correctIndex: 0,
    explanation: 'Use "will" for predictions about the future.',
  ),

  A2ExamQuestion(
    question: 'You ___ be careful when crossing the street.',
    options: [
      'should',
      'should to',
      'can to',
      'are',
    ],
    correctIndex: 0,
    explanation: '"Should + base verb" is used for advice.',
  ),

  A2ExamQuestion(
    question: 'There ___ a bank next to the supermarket.',
    options: [
      'are',
      'is',
      'have',
      'be',
    ],
    correctIndex: 1,
    explanation: 'Use "there is" with a singular noun.',
  ),

  A2ExamQuestion(
    question: 'She has ___ friends in this city.',
    options: [
      'much',
      'a little',
      'many',
      'any',
    ],
    correctIndex: 2,
    explanation: 'Friends are countable plural nouns, so use "many".',
  ),

  A2ExamQuestion(
    question: 'Could you ___ me with this problem?',
    options: [
      'help',
      'helping',
      'helped',
      'to helping',
    ],
    correctIndex: 0,
    explanation: 'After "could you", use the base form of the verb.',
  ),

  A2ExamQuestion(
    question: 'I have to ___ my project today.',
    options: [
      'finished',
      'finishing',
      'finish',
      'finishes',
    ],
    correctIndex: 2,
    explanation: 'After "have to", use the base form of the verb.',
  ),

  A2ExamQuestion(
    question: 'If it rains, we ___ stay at home.',
    options: [
      'will',
      'would',
      'did',
      'are',
    ],
    correctIndex: 0,
    explanation: 'In the first conditional, use "if + present simple, will + verb".',
  ),

  // ============================================================
  // REAL-LIFE SITUATIONS
  // ============================================================

  A2ExamQuestion(
    question: 'You are in a café. You want to ask for the menu politely. What do you say?',
    options: [
      'Give menu.',
      'I want menu.',
      'Could I see the menu, please?',
      'Menu now.',
    ],
    correctIndex: 2,
    explanation: '"Could I...?" is a polite way to make a request.',
  ),

  A2ExamQuestion(
    question: 'Someone says, "Thank you for your help." What is a natural response?',
    options: [
      'Never.',
      'You’re welcome.',
      'I disagree.',
      'Excuse me.',
    ],
    correctIndex: 1,
    explanation: '"You’re welcome" is a common response to "Thank you".',
  ),

  A2ExamQuestion(
    question: 'Your friend says, "Would you like to come to my party?" You want to accept.',
    options: [
      'Sure, I’d love to.',
      'No problem happened.',
      'I am not sure yesterday.',
      'That is impossible.',
    ],
    correctIndex: 0,
    explanation: '"Sure, I’d love to" is a natural way to accept an invitation.',
  ),

  A2ExamQuestion(
    question: 'You cannot hear someone clearly. What should you say?',
    options: [
      'Speak forever.',
      'Could you repeat that, please?',
      'I don’t want.',
      'You are wrong.',
    ],
    correctIndex: 1,
    explanation: '"Could you repeat that, please?" is a polite request.',
  ),

  A2ExamQuestion(
    question: 'You are late for a meeting. What is the best thing to say?',
    options: [
      'Sorry I’m late.',
      'Late is me.',
      'You wait me.',
      'Meeting finished.',
    ],
    correctIndex: 0,
    explanation: '"Sorry I’m late" is a natural apology for being late.',
  ),

  A2ExamQuestion(
    question: 'Your phone is not working. What can you say?',
    options: [
      'My phone is broken.',
      'My phone is delicious.',
      'My phone is crowded.',
      'My phone is sunny.',
    ],
    correctIndex: 0,
    explanation: '"Broken" describes something that does not work correctly.',
  ),

  A2ExamQuestion(
    question: 'You want to know where the pharmacy is. What do you ask?',
    options: [
      'Where pharmacy?',
      'Where is the pharmacy?',
      'Pharmacy is why?',
      'Do pharmacy where?',
    ],
    correctIndex: 1,
    explanation: '"Where is the pharmacy?" is the correct question.',
  ),

  A2ExamQuestion(
    question: 'Your friend looks tired. What advice can you give?',
    options: [
      'You should get some rest.',
      'You should to run.',
      'You are rest.',
      'You can tired.',
    ],
    correctIndex: 0,
    explanation: '"You should get some rest" is a natural way to give advice.',
  ),

  // ============================================================
  // SENTENCE ORDER / STRUCTURE
  // ============================================================

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'Usually I breakfast eat at home.',
      'I usually eat breakfast at home.',
      'I eat usually breakfast at home.',
      'Breakfast I eat usually at home.',
    ],
    correctIndex: 1,
    explanation: 'The natural order is subject + frequency adverb + verb + object.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'Yesterday went I to work.',
      'I went to work yesterday.',
      'I yesterday went work to.',
      'Went I yesterday to work.',
    ],
    correctIndex: 1,
    explanation: '"I went to work yesterday" is the correct word order.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'She is watching TV now.',
      'She watching is TV now.',
      'She now watching TV is.',
      'Is she watching TV now.',
    ],
    correctIndex: 0,
    explanation: 'The affirmative present continuous structure is subject + be + verb-ing.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'I am going to visit my cousin tomorrow.',
      'I going am to visit my cousin tomorrow.',
      'I am visit going my cousin tomorrow.',
      'I tomorrow going visit am my cousin.',
    ],
    correctIndex: 0,
    explanation: 'The correct structure is subject + be + going to + verb.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'Could you help me, please?',
      'Could help you me, please?',
      'You could me help, please?',
      'Help could me you, please?',
    ],
    correctIndex: 0,
    explanation: 'The natural request structure is "Could you + base verb...?"',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'There are two chairs in the room.',
      'There two chairs are in the room.',
      'Two chairs there is in the room.',
      'Are there two chairs the room.',
    ],
    correctIndex: 0,
    explanation: 'Use "There are" before a plural noun.',
  ),

  // ============================================================
  // READING COMPREHENSION
  // ============================================================

  A2ExamQuestion(
    question:
        'Read: "Emma gets up at 7 every morning. She usually has breakfast at home before she goes to work." What does Emma usually do before work?',
    options: [
      'She goes shopping.',
      'She has breakfast.',
      'She exercises at school.',
      'She visits her friend.',
    ],
    correctIndex: 1,
    explanation: 'The text says Emma usually has breakfast at home before work.',
  ),

  A2ExamQuestion(
    question:
        'Read: "Tom went to the pharmacy because he had a headache. The pharmacist gave him some medicine." Why did Tom go to the pharmacy?',
    options: [
      'He needed a new phone.',
      'He wanted some food.',
      'He had a headache.',
      'He wanted to meet his friend.',
    ],
    correctIndex: 2,
    explanation: 'Tom went to the pharmacy because he had a headache.',
  ),

  A2ExamQuestion(
    question:
        'Read: "Sarah is going to travel to Spain next month. She has already bought her ticket and booked a hotel." What has Sarah already done?',
    options: [
      'She has canceled the trip.',
      'She has bought a ticket and booked a hotel.',
      'She has visited Spain.',
      'She has changed her job.',
    ],
    correctIndex: 1,
    explanation: 'The text says she has already bought her ticket and booked a hotel.',
  ),

  A2ExamQuestion(
    question:
        'Read: "It was raining heavily, so Jack stayed at home and watched a movie." Why did Jack stay home?',
    options: [
      'Because he was sick.',
      'Because he was working.',
      'Because it was raining heavily.',
      'Because he had an appointment.',
    ],
    correctIndex: 2,
    explanation: 'Jack stayed home because it was raining heavily.',
  ),

  A2ExamQuestion(
    question:
        'Read: "Lisa works in an office. She starts at 9 and usually finishes at 5. Today, however, she is working until 7 because she has an important project." Why is Lisa working until 7 today?',
    options: [
      'She has an important project.',
      'She has a doctor appointment.',
      'She is learning English.',
      'She is going shopping.',
    ],
    correctIndex: 0,
    explanation: 'The text says she is working late because of an important project.',
  ),

  A2ExamQuestion(
    question:
        'Read: "Mike wanted to buy a new laptop, but it was too expensive. Instead, he bought a used one." Why did Mike buy a used laptop?',
    options: [
      'The new laptop was too expensive.',
      'The used laptop was broken.',
      'He did not need a laptop.',
      'The store was closed.',
    ],
    correctIndex: 0,
    explanation: 'He chose the used laptop because the new one was too expensive.',
  ),

  // ============================================================
  // CONVERSATION
  // ============================================================

  A2ExamQuestion(
    question:
        'Anna: "Would you like some coffee?"\nBen: "___"',
    options: [
      'Yes, please.',
      'I am coffee.',
      'No, I would like yesterday.',
      'Coffee is difficult.',
    ],
    correctIndex: 0,
    explanation: '"Yes, please" is a natural way to accept an offer.',
  ),

  A2ExamQuestion(
    question:
        'Customer: "Excuse me, my order is wrong."\nWaiter: "___"',
    options: [
      'I don’t care.',
      'I’m sorry. Let me check it.',
      'Wrong is good.',
      'You order yesterday.',
    ],
    correctIndex: 1,
    explanation: 'The waiter should apologize and offer to check the problem.',
  ),

  A2ExamQuestion(
    question:
        'John: "What do you usually do at weekends?"\nMary: "___"',
    options: [
      'I usually meet my friends.',
      'Yesterday was blue.',
      'I am weekend.',
      'Because I like.',
    ],
    correctIndex: 0,
    explanation: 'The question asks about a routine, so a present simple answer is appropriate.',
  ),

  A2ExamQuestion(
    question:
        'Sam: "I’m feeling sick today."\nAlex: "___"',
    options: [
      'You should get some rest.',
      'You should to work harder.',
      'You are sickness.',
      'You can sick.',
    ],
    correctIndex: 0,
    explanation: '"You should get some rest" is appropriate advice.',
  ),

  A2ExamQuestion(
    question:
        'Emma: "Do you prefer movies or books?"\nTom: "___"',
    options: [
      'I prefer books to movies.',
      'I prefer books than movies.',
      'I am prefer books.',
      'Books prefer me.',
    ],
    correctIndex: 0,
    explanation: 'The correct structure is "prefer A to B".',
  ),

  A2ExamQuestion(
    question:
        'A: "Sorry, I’m late."\nB: "___"',
    options: [
      'That’s okay.',
      'You are welcome.',
      'Nice to meet you.',
      'I disagree.',
    ],
    correctIndex: 0,
    explanation: '"That’s okay" is a natural response to an apology.',
  ),

  // ============================================================
  // MIXED A2
  // ============================================================

  A2ExamQuestion(
    question: 'Which sentence is correct?',
    options: [
      'I have visited my grandmother yesterday.',
      'I visited my grandmother yesterday.',
      'I visit my grandmother yesterday.',
      'I am visit my grandmother yesterday.',
    ],
    correctIndex: 1,
    explanation: 'Use the past simple with a finished past time such as "yesterday".',
  ),

  A2ExamQuestion(
    question: 'Which sentence is correct?',
    options: [
      'She can to swim.',
      'She can swimming.',
      'She can swim.',
      'She cans swim.',
    ],
    correctIndex: 2,
    explanation: 'After "can", use the base form of the verb.',
  ),

  A2ExamQuestion(
    question: 'Which sentence is correct?',
    options: [
      'I need to finish this task.',
      'I need finish to this task.',
      'I need finishing this task.',
      'I to need finish this task.',
    ],
    correctIndex: 0,
    explanation: 'The correct structure is "need to + base verb".',
  ),

  A2ExamQuestion(
    question: 'Which sentence sounds the most natural?',
    options: [
      'Give me a second, please.',
      'Give I second.',
      'Second me give.',
      'I second give you.',
    ],
    correctIndex: 0,
    explanation: '"Give me a second" is a common everyday expression meaning "wait briefly".',
  ),

  A2ExamQuestion(
    question: 'Choose the best response: "I’m not sure where the station is."',
    options: [
      'I can check it for you.',
      'Station is impossible.',
      'You are station.',
      'I checked tomorrow.',
    ],
    correctIndex: 0,
    explanation: '"I can check it for you" is a natural and helpful response.',
  ),

  A2ExamQuestion(
    question: 'Choose the best sentence for a future prediction.',
    options: [
      'I think it will be sunny tomorrow.',
      'I think it was sunny tomorrow.',
      'I think it is sunny yesterday.',
      'I think it sunny tomorrow.',
    ],
    correctIndex: 0,
    explanation: '"Will" is commonly used for future predictions.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'I have to leave now.',
      'I have leave to now.',
      'I have to leaving now.',
      'I has to leave now.',
    ],
    correctIndex: 0,
    explanation: 'Use "have to + base verb".',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'My sister is more friendly than my brother.',
      'My sister is friendlyer than my brother.',
      'My sister more friendly my brother.',
      'My sister is most friendly than my brother.',
    ],
    correctIndex: 0,
    explanation: 'For many longer adjectives, use "more + adjective".',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'I don’t have any questions.',
      'I don’t have some questions.',
      'I don’t have much questions.',
      'I don’t have a questions.',
    ],
    correctIndex: 0,
    explanation: 'Use "any" in negative sentences with plural countable nouns.',
  ),

  A2ExamQuestion(
    question: 'Choose the best response: "What does this word mean?"',
    options: [
      'It means "something very useful."',
      'It meaning useful.',
      'Means it yesterday.',
      'I am meaning.',
    ],
    correctIndex: 0,
    explanation: '"It means..." is the natural structure for explaining a word.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'I was tired, so I went to bed early.',
      'I was tired, because I went to bed early.',
      'I tired so went bed.',
      'I was tired but I went bed early because.',
    ],
    correctIndex: 0,
    explanation: '"So" can connect a reason with its result.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'If I have time, I will call you.',
      'If I will have time, I call you.',
      'If I had time, I will called you.',
      'If I have time, I calling you.',
    ],
    correctIndex: 0,
    explanation: 'First conditional: if + present simple, will + base verb.',
  ),

  A2ExamQuestion(
    question: 'Which sentence is the most polite?',
    options: [
      'Open the window.',
      'Can you open the window, please?',
      'You open window.',
      'Window. Now.',
    ],
    correctIndex: 1,
    explanation: '"Can you... please?" is a polite everyday request.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct question.',
    options: [
      'How often do you exercise?',
      'How often you exercise?',
      'How do often you exercise?',
      'How often are you exercise?',
    ],
    correctIndex: 0,
    explanation: 'The correct present simple question structure is "How often do you...?"',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'I am interested in photography.',
      'I am interesting in photography.',
      'I interested photography.',
      'I am interest in photography.',
    ],
    correctIndex: 0,
    explanation: '"Interested" describes how a person feels about something.',
  ),

  A2ExamQuestion(
    question: 'Choose the best response to: "Nice to meet you."',
    options: [
      'Nice to meet you too.',
      'I meet yesterday.',
      'You are nice.',
      'Meet is difficult.',
    ],
    correctIndex: 0,
    explanation: '"Nice to meet you too" is the standard natural response.',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'There isn’t any milk in the fridge.',
      'There aren’t any milk in the fridge.',
      'There isn’t many milk in the fridge.',
      'There not is milk in the fridge.',
    ],
    correctIndex: 0,
    explanation: 'Milk is uncountable, so use "there isn’t any milk".',
  ),

  A2ExamQuestion(
    question: 'Choose the correct sentence.',
    options: [
      'She has worked here for two years.',
      'She has work here for two years.',
      'She worked here since two years.',
      'She is work here for two years.',
    ],
    correctIndex: 0,
    explanation: '"Has worked" correctly expresses a situation continuing up to now.',
  ),

  A2ExamQuestion(
    question: 'Choose the best answer: "What are you doing this evening?"',
    options: [
      'I’m meeting a friend.',
      'I meet yesterday.',
      'I met tomorrow.',
      'I am meet friend yesterday.',
    ],
    correctIndex: 0,
    explanation: 'Present continuous can describe a planned future arrangement.',
  ),

  A2ExamQuestion(
    question: 'Choose the most natural sentence.',
    options: [
      'Take your time. There is no hurry.',
      'Take your times. No hurry is.',
      'You take time your.',
      'Time take because hurry.',
    ],
    correctIndex: 0,
    explanation: '"Take your time" is a common expression meaning there is no need to hurry.',
  ),
];

int get a2ExamTotalQuestions => a2ExamQuestions.length;