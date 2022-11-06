package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoAdditionalDataVO extends DAAPIDataClass
   {
      
      private static const BLOCKS_DATA_FIELD:String = "blocks";
       
      
      public var index:int = -1;
      
      public var icon:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var notificationIcon:String = "";
      
      public var notificationLabel:String = "";
      
      private var _infoBlocks:Vector.<InfoAdditionalBlockDataVO> = null;
      
      public function InfoAdditionalDataVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BLOCKS_DATA_FIELD && param2 != null)
         {
            this._infoBlocks = Vector.<InfoAdditionalBlockDataVO>(App.utils.data.convertVOArrayToVector(param1,param2,InfoAdditionalBlockDataVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._infoBlocks != null)
         {
            for each(_loc1_ in this._infoBlocks)
            {
               _loc1_.dispose();
            }
            this._infoBlocks.splice(0,this._infoBlocks.length);
            this._infoBlocks = null;
         }
         super.onDispose();
      }
      
      public function get infoBlocks() : Vector.<InfoAdditionalBlockDataVO>
      {
         return this._infoBlocks;
      }
   }
}
