package org.idmedia.as3commons.util
{
   public class HashMap extends AbstractMap implements Map
   {
       
      
      private var entries:Set;
      
      public function HashMap()
      {
         super();
         this.entries = new EntrySet();
      }
      
      override public function entrySet() : Set
      {
         return this.entries;
      }
      
      override public function put(param1:*, param2:*) : *
      {
         var _loc4_:Entry = null;
         var _loc5_:* = undefined;
         var _loc3_:Iterator = this.entries.iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = Entry(_loc3_.next());
            if(_loc4_.getKey() === param1)
            {
               _loc5_ = _loc4_.getValue();
               _loc4_.setValue(param2);
               return _loc5_;
            }
         }
         this.entries.add(new EntryImpl(param1,param2));
         return null;
      }
      
      public function forEach(param1:Function) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Array = this.keySet().toArray();
         for each(_loc3_ in _loc2_)
         {
            param1(_loc3_,this.get(_loc3_));
         }
      }
   }
}

import org.idmedia.as3commons.util.Entry;

class EntryImpl implements Entry
{
    
   
   private var key;
   
   private var value;
   
   function EntryImpl(param1:*, param2:*)
   {
      super();
      this.key = param1;
      this.value = param2;
   }
   
   public function getKey() : *
   {
      return this.key;
   }
   
   public function getValue() : *
   {
      return this.value;
   }
   
   public function setValue(param1:*) : *
   {
      var _loc2_:* = this.value;
      this.value = param1;
      return _loc2_;
   }
   
   public function equals(param1:*) : Boolean
   {
      return param1 === this;
   }
}
