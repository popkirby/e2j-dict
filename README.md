e2j_dict: English-to-Japanese Dictionary Generator
----------------

## Overview
`e2j_dict.rb` generates pairs of English word to Japanese "yomi" as JSON file.

The format of the output JSON file is like below:

```json
[
  {
    "word": "T-shirt",
    "yomi": ["ティーシャツ"]
  },
  {
    "word": "useless",
    "yomi": ["あかん", "アカン"]
  }
]
```

## Usage
```sh
./generator.sh
```

or, download `JMdict-e.xml` from http://www.edrdg.org/jmdict/edict_doc.html and

```sh
bundle exec ruby e2j_dict.rb JMdict-e.xml e2j_result.json
```

## License
Generated file (`e2j_*.json` if you use `generator.sh`) has ncluded material from the JMdict
dictionary files in accordance with the licence provisions of the Electronic Dictionaries Research Group.
See http://www.csse.monash.edu.au/~jwb/edict.html and http://www.edrdg.org/ .

Other scripts (like `generator.sh` and `e2j_dict.rb`) are licensed under Apache License, Version 2.0.
For more information, see http://www.apache.org/licenses/LICENSE-2.0 .

