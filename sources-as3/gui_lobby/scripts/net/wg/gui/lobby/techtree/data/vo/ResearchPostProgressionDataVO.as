package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ResearchPostProgressionDataVO extends DAAPIDataClass
   {
      
      private static const MODULE_IDS_FIELD_NAME:String = "moduleIds";
       
      
      public var state:int = -1;
      
      public var label:String = "";
      
      public var vehicleId:uint = 0;
      
      public var _moduleIds:Vector.<uint> = null;
      
      public function ResearchPostProgressionDataVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._moduleIds)
         {
            this._moduleIds.length = 0;
            this._moduleIds = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         if(param1 == MODULE_IDS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"moduleIds must be Array");
            this._moduleIds = new Vector.<uint>();
            for each(_loc4_ in _loc3_)
            {
               this._moduleIds.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get moduleIds() : Vector.<uint>
      {
         return this._moduleIds;
      }
   }
}
