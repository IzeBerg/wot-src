package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.IndexOutOfBoundsException;
   import org.idmedia.as3commons.lang.NullPointerException;
   
   public class ArrayList extends AbstractList implements List
   {
       
      
      private var elementData:Array;
      
      private var elementSize:int;
      
      public function ArrayList(param1:Collection = null)
      {
         super();
         this.elementData = new Array();
         this.elementSize = 0;
         if(param1 != null)
         {
            this.elementData = this.elementData.concat(param1.toArray());
            this.elementSize = this.elementData.length;
         }
      }
      
      override public function add(param1:*) : Boolean
      {
         var _loc2_:* = this.elementSize++;
         this.elementData[_loc2_] = param1;
         return true;
      }
      
      override public function setAt(param1:int, param2:*) : Boolean
      {
         this.rangeCheck(param1);
         this.elementData[param1] = param2;
         return true;
      }
      
      override public function addAt(param1:int, param2:*) : Boolean
      {
         this.rangeCheck(param1);
         var _loc3_:Array = this.elementData.slice(0,param1);
         var _loc4_:Array = this.elementData.slice(param1);
         this.elementData = _loc3_.concat(param2).concat(_loc4_);
         this.elementSize = this.elementData.length;
         return true;
      }
      
      override public function addAll(param1:Collection) : Boolean
      {
         if(param1 == null)
         {
            throw new NullPointerException();
         }
         var _loc2_:Array = param1.toArray();
         var _loc3_:int = this.elementSize + _loc2_.length;
         this.elementData = this.elementData.concat(_loc2_);
         this.elementSize = this.elementData.length;
         return this.elementSize === _loc3_;
      }
      
      override public function get(param1:int) : *
      {
         this.rangeCheck(param1);
         return this.elementData[param1];
      }
      
      override public function removeAt(param1:int) : Boolean
      {
         return this.removeAtTo(param1,1);
      }
      
      override public function removeAtAndReturn(param1:int) : *
      {
         return this.removeAtToAndReturn(param1,1);
      }
      
      override public function removeAtTo(param1:int, param2:int) : Boolean
      {
         this.rangeCheck(param1);
         this.elementData.splice(param1,param2);
         this.elementSize = this.elementData.length;
         return true;
      }
      
      public function removeAtToAndReturn(param1:int, param2:int) : *
      {
         this.rangeCheck(param1);
         var _loc3_:* = this.get(param1);
         this.removeAtTo(param1,param2);
         return _loc3_;
      }
      
      override public function clear() : void
      {
         this.elementData = new Array();
         this.elementSize = 0;
      }
      
      override public function size() : int
      {
         return int(this.elementSize) || int(0);
      }
      
      override public function isEmpty() : Boolean
      {
         return this.elementSize == 0;
      }
      
      override public function toArray() : Array
      {
         return [].concat(this.elementData);
      }
      
      private function rangeCheck(param1:int) : void
      {
         if(param1 > this.elementSize || param1 < 0)
         {
            throw new IndexOutOfBoundsException("Index: " + param1 + ", " + "Size: " + this.elementSize);
         }
      }
   }
}
