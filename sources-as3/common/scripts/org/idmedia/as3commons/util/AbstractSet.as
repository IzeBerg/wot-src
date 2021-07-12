package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.NullPointerException;
   
   public class AbstractSet extends AbstractCollection implements Set
   {
       
      
      public function AbstractSet()
      {
         super();
      }
      
      override public function equals(param1:*) : Boolean
      {
         var o:* = param1;
         if(o === this)
         {
            return true;
         }
         if(!(o is Set))
         {
            return false;
         }
         var c:Collection = Collection(o);
         if(c.size() != size())
         {
            return false;
         }
         try
         {
            return containsAll(c);
         }
         catch(unused:NullPointerException)
         {
            return false;
         }
      }
   }
}
