import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('qotd-tag')
class QotdTag extends PolymerElement {
  @published String source;
  @published String quote;
  
  QotdTag.created() : super.created() {
    
    var root = getShadowRoot("qotd-tag");
    root.applyAuthorStyles = true;
    
    getQuote();
  }
  
  
  
  
  void getQuote()
  {
    var path='http://rsywx/app_dev.php/json/qotd';
    var req=new HttpRequest();
    
   
    HttpRequest.getString(path)
      .then((String res)
          {
            processQotd(res);
          });
    
    /*req..open('GET', path)
      ..onLoadEnd.listen((e)=>requestComplete(req))
      ..send('');*/
  }
  
  void processQotd(String res)
  {
    Map q=JSON.decode(res);
    quote=q['quote'];
    source=q['source'];
    
  }
  
  
  
}
