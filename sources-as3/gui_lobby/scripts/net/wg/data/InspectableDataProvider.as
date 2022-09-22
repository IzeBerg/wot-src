package net.wg.data
{
   import scaleform.clik.data.DataProvider;
   
   public dynamic class InspectableDataProvider extends DataProvider
   {
       
      
      public function InspectableDataProvider()
      {
         super();
      }
      
      public function addItem(param1:Object) : void
      {
         push(param1);
      }
      
      public function addItemAt(param1:Object, param2:uint) : void
      {
         splice(param2,0,param1);
      }
      
      public function getItemAt(param1:uint) : Object
      {
         return this[param1];
      }
      
      public function getItemIndex(param1:Object) : int
      {
         return indexOf(param1);
      }
      
      public function removeItem(param1:Object) : Object
      {
         var _loc2_:int = indexOf(param1);
         return splice(_loc2_,1);
      }
      
      public function removeItemAt(param1:uint) : Object
      {
         return splice(param1,1);
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = this[param1];
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
   }
}
