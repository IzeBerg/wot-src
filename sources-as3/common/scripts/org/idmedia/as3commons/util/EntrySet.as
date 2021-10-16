package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.IllegalArgumentException;
   
   class EntrySet extends AbstractSet
   {
       
      
      private var table:Array;
      
      private var tableSize:int;
      
      function EntrySet()
      {
         super();
         this.table = new Array();
         this.tableSize = 0;
      }
      
      override public function iterator() : Iterator
      {
         return new EntrySetIterator(this);
      }
      
      override public function add(param1:*) : Boolean
      {
         if(!(param1 is Entry))
         {
            throw new IllegalArgumentException();
         }
         if(!contains(param1))
         {
            this.table.push(param1);
            ++this.tableSize;
            return true;
         }
         return false;
      }
      
      override public function remove(param1:* = null) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.tableSize)
         {
            if(Entry(param1).equals(this.table[_loc2_]))
            {
               this.table.splice(_loc2_,1);
               --this.tableSize;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get(param1:int) : *
      {
         return this.table[param1];
      }
      
      public function removeEntryForKey(param1:*) : Entry
      {
         var _loc2_:Entry = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.tableSize)
         {
            if(Entry(this.table[_loc3_]).getKey() === param1)
            {
               _loc2_ = this.table[_loc3_];
               this.table.splice(_loc3_,1);
               --this.tableSize;
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function size() : int
      {
         return this.tableSize;
      }
   }
}
