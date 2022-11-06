package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TankCarouselFilterSelectedVO extends DAAPIDataClass
   {
      
      private static const HOT_FILTERS:String = "hotFilters";
       
      
      private var _hotFilters:Vector.<Boolean> = null;
      
      public function TankCarouselFilterSelectedVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._hotFilters.splice(0,this._hotFilters.length);
         this._hotFilters = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         if(param1 == HOT_FILTERS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"hotFilters must be Array");
            this._hotFilters = new Vector.<Boolean>();
            for each(_loc4_ in _loc3_)
            {
               this._hotFilters.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get hotFilters() : Vector.<Boolean>
      {
         return this._hotFilters;
      }
   }
}
