#import('dart:html');
#import('dart:core');



class Morsetranslator {
  String dot = '.';
  String dash = '_';
  String text = "";
  String type = "MORSETOTEXT";
  String lang = "ru";
  TextAreaElement result;
  var cba = const{
    "._" : "AaАа" ,
    "_..." : "BbБб",
    "_._." : "CcЦц",
    "_.." : "DdДд",
    "." : "EeЕеЁё",
    ".._." : "FfФф",
    "__." : "GgГг",
    "...." : "HhХх",
    ".." : "IiИи",
    ".___" : "JjЙй",
    "_._" : "KkКк",
    "._.." : "LlЛл",
    "__" : "MmМм",
    "_." : "NnНн",
    "___" : "OoОо",
    ".__." : "PpПп",
    "__._" : "QqЩщ",
    "._." : "RrРр",
    "..." : "SsСс",
    "_" : "TtТт",
    ".._" : "UuУу",
    "..._" : "VvЖж",
    ".__" : "WwВв",
    "_.._" : "XxЪъЬь",
    "_.__" : "YyЫы",
    "__.." : "ZzЗз",
    "_____" : "0000",
    ".____" : "1111",
    "..___" : "2222",
    "...__" : "3333",
    "...._" : "4444",
    "....." : "5555",
    "_...." : "6666",
    "__..." : "7777",
    "___.." : "8888",
    "____." : "9999",
    "......" : "....",
    "._._._" : ",,,,",
    "___..." : "::::",
    "_._._." : ";;;;",
    "_.__._" : "((((",
    ".____." : "````",
    "._.._." : "\"\"\"\"",
    "_...._" : "----",
    "_.._." : "////",
    "..__.." : "????",
    "__..__" : "!!!!",
    "_..._" : "    ",
    ".__._." : "@@@@",
    "........" : "ERROR",
    ".._._" : "END",
    "____" : "chШш",
    "..__" : "ÜÜЮю",
    "___." : "ÖÖЧч",
    "._._" : "ÄÄЯя",
    ".._.." : "ÉÉЭэ"
  };
  var abc = const{
             "AaАа" : "._",
             "BbБб" : "_...",
             "CcЦц" : "_._.",
             "DdДд" : "_..",
             "EeЕеЁё" : ".",
             "FfФф" : ".._.",
             "GgГг" : "__.",
             "HhХх" : "....",
             "IiИи" : "..",
             "JjЙй" : ".___",
             "KkКк" : "_._",
             "LlЛл" : "._..",
             "MmМм" : "__",
             "NnНн" : "_.",
             "OoОо" : "___",
             "PpПп" : ".__.",
             "QqЩщ" : "__._",
             "RrРр" : "._.",
             "SsСс" : "...",
             "TtТт" : "_",
             "UuУу" : ".._",
             "VvЖж" : "..._",
             "WwВв" : ".__",
             "XxЪъЬь" : "_.._",
             "YyЫы" : "_.__",
             "ZzЗз" : "__..",
             "0000" : "_____",
             "1111" : ".____",
             "2222" : "..___",
             "3333" : "...__",
             "4444" : "...._",
             "5555" : ".....",
             "6666" : "_....",
             "7777" : "__...",
             "8888" : "___..",
             "9999" : "____.",
             "...." : ".....",
             ",,,," : "._._._",
             "::::" : "___...",
             ";;;;" : "_._._.",
             "((((" : "_.__._",
             "````" : ".____.",
             "\"\"\"\"" : "._.._.",
             "----" : "_...._",
             "////" : "_.._.",
             "????" : "..__..",
             "!!!!" : "__..__",
             "    " : "_..._",
             "@@@@" : ".__._.",
             "ERROR" : "........",
             "END" : ".._._",
             "chШш" : "____",
             "ÜÜЮю" : "..__",
             "ÖÖЧч" : "___.",
             "ÄÄЯя" : "._._",
             "ÉÉЭэ" : ".._.."
             
  };
  
  Morsetranslator() {
    
  }

  void getPatterns() {
    window.console.log("getPatterns() started");
    TextAreaElement tae = document.query("#text");
    this.text = tae.value; 
    InputElement dotElement = document.query("#dotPattern");
    String dotPattern = dotElement.value;
    InputElement dashElement = document.query("#dashPattern");
    String dashPattern = dashElement.value;
    window.console.log("getPattern() this.text = " + this.text);
    this.result = document.query("#result");
    
    SelectElement selEl = document.query("#lang");
    this.lang = selEl.value;
    window.console.log(selEl.value);
    selEl = document.query("#type");
    window.console.log(selEl.value);
    this.type = selEl.value;
    
    if(dotPattern != "") {
      this.dot = dotPattern;
    }
    if(dashPattern != "") {
      this.dash = dashPattern;
    }
    window.console.log("getPatterns() ended");
    window.alert("html: " + selEl.value);
    window.alert("dart: " + type);
  }
  void init() {
    window.console.log("init() started");
    result = document.query("#result");
    //document.query("#translate").on.click.add(void _(evt){window.console.log("pressed");});
    document.query("#translate").on.click.add(void _(evt){result.value = translate();} );
    document.query("#type").on.change.add((evt){
      window.console.log("тут варнинг уеба! type is " + document.query("#type").value);
      if(document.query("#type").value == "MORSETOTEXT") {
        document.query("#lang").style.visibility = "visible";
        window.console.log("lang setted to visible state");
      }
      else {
        document.query("#lang").style.visibility = "hidden";
        window.console.log("lang setted to hidden state");
      }
    });
    
    document.query("#loading").style.visibility = "hidden";
    window.console.log("init() ended");
  }
  
  String translate() {
    window.console.log("translate() started");
    result.value = "";
    getPatterns();
    if(type == "MORSETOTEXT") {
      return morseToText(text, dot, dash);
    }
    else {
      return textToMorse(text, dot, dash);
    }
    
  }
  
  String textToMorse(String rowText, String dotPattern, String dashPattern) {
    String textProcessed = "";
    for(int i=0;i<rowText.length; i++) {
      abc.forEach((k, v) {
        String K = k;
        for(int j=0;j<K.length;j++) {
          if(K[j] == rowText[i]) {
            textProcessed += v + " ";
            break;
          }
        }
        }
      );
    }
    textProcessed.replaceAll(".", dot);
    textProcessed.replaceAll("_", dash);
    return textProcessed;
  }
  
  String morseToText(String rowText, String dotPattern, String dashPattern) {
    window.console.log("morseToText() started with " + "rowText: " + rowText + " dotPattern: " + dotPattern + " dashPattern: " + dashPattern);
    String word = "";
    String textProcessed = "";
    rowText = rowText.replaceAll(dotPattern, ".");
    rowText = rowText.replaceAll(dashPattern, "_");
    for(int i=0; i<rowText.length; i++) {
      window.console.log("in the for rowText[i] = " + rowText[i]);
      if(rowText[i] == ' ' || i + 1 == rowText.length) {
        if(i + 1 == rowText.length) {  // last symbol
          word += rowText[i];
          word = word.replaceAll(" ", ""); // пока так
          }
        window.console.log("word = \"" + word + "\"");
        window.console.log("translated word = " + cba[word]);
        
        try { // TODO КОСТЫЛЬ! на самом деле тут везде сплошные костыли, но этот ваще жуть!
          window.console.log("зашли в трай");
          window.console.log("язык у нас: $lang");
          window.console.log("зашли в трай");
          
          String character; // String because some "characters" has one or two characters
          if(lang == "ru")
            textProcessed += (cba[word])[2]; // TODO потом добавить параметры "слов"
          if(lang == "eng")
            textProcessed += (cba[word])[0];
          
        }
        catch(NullPointerException ex)
        {
          window.console.log(ex.toString());
          // улыбаемся и машем
        }
        catch(Exception ex)
        {
          window.console.log(ex.toString());
          //рррр опять машем
        }
          word = "";
        window.console.log("on each word " + textProcessed);
        continue;
      }
      word += rowText[i];
      
    }
    
   return textProcessed; 
  }
}

void main() {
  Morsetranslator mt = new Morsetranslator();
  mt.init();
  
}
