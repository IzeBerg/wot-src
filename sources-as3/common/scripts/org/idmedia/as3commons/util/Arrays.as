package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.NullPointerException;
   
   public final class Arrays
   {
       
      
      public function Arrays()
      {
         super();
      }
      
      public static function asList(param1:Array) : List
      {
         var l:List = null;
         var a:Array = param1;
         if(a == null)
         {
            throw new NullPointerException();
         }
         l = new ArrayList();
         var copy:Array = [].concat(a);
         copy.forEach(function(param1:*, param2:int, param3:Array):void
         {
            l.add(param1);
         });
         return l;
      }
      
      public static function sort(param1:Array, param2:Comparator) : void
      {
         param1.sort(param2.compare);
      }
   }
}
