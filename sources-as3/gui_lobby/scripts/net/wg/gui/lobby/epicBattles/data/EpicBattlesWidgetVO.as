package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class EpicBattlesWidgetVO extends DAAPIDataClass
   {
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
       
      
      public var epicMetaLevelIconData:MetaLevelVO = null;
      
      public var points:String = "";
      
      public function EpicBattlesWidgetVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.epicMetaLevelIconData != null)
         {
            this.epicMetaLevelIconData.dispose();
            this.epicMetaLevelIconData = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == EPIC_META_LEVEL_ICON_VO)
         {
            this.epicMetaLevelIconData = new MetaLevelVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
