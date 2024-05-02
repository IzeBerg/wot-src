package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionFirstEntryViewVO extends DAAPIDataClass
   {
      
      private static const INFO_BLOCKS:String = "infoBlocks";
       
      
      public var bgSource:String = "";
      
      public var titleLabel:String = "";
      
      public var bigBtnLabel:String = "";
      
      public var playVideoBtnLabel:String = "";
      
      public var playVideoBtnVisible:Boolean = false;
      
      public var backBtnLabel:String = "";
      
      public var isFirstEntry:Boolean = false;
      
      private var _infoBlocks:Vector.<InfoItemRendererVO> = null;
      
      public function PersonalMissionFirstEntryViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == INFO_BLOCKS && param2 != null)
         {
            this._infoBlocks = Vector.<InfoItemRendererVO>(App.utils.data.convertVOArrayToVector(param1,param2,InfoItemRendererVO));
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
      
      public function get infoBlocks() : Vector.<InfoItemRendererVO>
      {
         return this._infoBlocks;
      }
   }
}
