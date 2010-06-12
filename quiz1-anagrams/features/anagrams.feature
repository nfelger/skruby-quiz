Feature: Anagrams Shmanagrams

Scenario: Binary anagram sets
  Given the following word list:
    | halls |
    | shall |
  When I run 'make_anagrams'
  Then the output should be:
    | halls shall |
    | shall halls |

Scenario: Exclude words with punctiation
  Given the following word list:
    | a.!   |
    | !a.   |
    | halls |
    | shall |
  When I run 'make_anagrams'
  Then the output should be:
    | halls shall |
    | shall halls |

Scenario: Exclude unary anagram sets
  Given the following word list:
    | asd   |
    | halls |
    | shall |
  When I run 'make_anagrams'
  Then the output should be:
    | halls shall |
    | shall halls |

Scenario: Anagram sets larger than 2 elements
  Given the following word list:
    | headskin |
    | nakedish |
    | sinkhead |
  When I run 'make_anagrams'
  Then the output should be:
    | headskin nakedish sinkhead |
    | nakedish (See 'headskin')  |
    | sinkhead (See 'headskin')  |

Scenario: Output should be in alphabetical order
  Given the following word list:
    | 5th      |
    | ascot    |
    | ate      |
    | carrot   |
    | coast    |
    | coats    |
    | cots     |
    | Dorian   |
    | eat      |
    | halls    |
    | headskin |
    | inroad   |
    | nakedish |
    | ordain   |
    | Ronald's |
    | shall    |
    | sinkhead |
    | tacos    |
    | tea      |
  When I run 'make_anagrams'
  Then the output should be:
    | Dorian inroad ordain       |
    | ascot coast coats tacos    |
    | ate eat tea                |
    | coast (See 'ascot')        |
    | coats (See 'ascot')        |
    | eat (See 'ate')            |
    | halls shall                |
    | headskin nakedish sinkhead |
    | inroad (See 'Dorian')      |
    | nakedish (See 'headskin')  |
    | ordain (See 'Dorian')      |
    | shall halls                |
    | sinkhead (See 'headskin')  |
    | tacos (See 'ascot')        |
    | tea (See 'ate')            |
    