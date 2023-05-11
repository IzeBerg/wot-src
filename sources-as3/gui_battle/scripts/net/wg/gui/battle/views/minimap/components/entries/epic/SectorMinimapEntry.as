package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   
   public class SectorMinimapEntry extends BattleUIComponent
   {
      
      private static const WARNING_STRING:String = "Warning";
       
      
      private var _state:String = null;
      
      private var _isWarningOn:Boolean = false;
      
      public function SectorMinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         stop();
         super.onDispose();
      }
      
      public function changeSectorState(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = EpicMinimapEntryConst.SECTOR_STATE_FIGHTING_ATLAS_ITEM_NAME;
         switch(param1)
         {
            case EPIC_CONSTS.SECTOR_CLOSED:
               _loc4_ = !param2 ? EpicMinimapEntryConst.SECTOR_STATE_INACTIVE_ATLAS_ITEM_NAME : EpicMinimapEntryConst.SECTOR_STATE_CLOSED_ATLAS_ITEM_NAME;
               break;
            case EPIC_CONSTS.SECTOR_FIGHTING:
               _loc4_ = EpicMinimapEntryConst.SECTOR_STATE_FIGHTING_ATLAS_ITEM_NAME;
               break;
            case EPIC_CONSTS.SECTOR_CLOSING:
               _loc4_ = !param2 ? EpicMinimapEntryConst.SECTOR_STATE_AIR_STRIKE_ATLAS_ITEM_NAME : EpicMinimapEntryConst.SECTOR_STATE_AIR_SUPPORT_ATLAS_ITEM_NAME;
               break;
            case EPIC_CONSTS.SECTOR_CAPTURED:
               _loc4_ = EpicMinimapEntryConst.SECTOR_STATE_CAPTURED_ATLAS_ITEM_NAME;
               break;
            case EPIC_CONSTS.SECTOR_BOMBING:
               _loc4_ = !param2 ? EpicMinimapEntryConst.SECTOR_STATE_AIR_STRIKE_ATLAS_ITEM_NAME : EpicMinimapEntryConst.SECTOR_STATE_AIR_SUPPORT_ATLAS_ITEM_NAME;
         }
         if(param3)
         {
            _loc4_ += EpicMinimapEntryConst.SECTOR_HQ_POSTFIX_ATLAS_ITEM_NAME;
         }
         this.setState(_loc4_);
      }
      
      public function setWarning(param1:Boolean) : void
      {
         if(this._isWarningOn == param1)
         {
            return;
         }
         this._isWarningOn = param1;
         gotoAndPlay(!!param1 ? this._state + WARNING_STRING : this._state);
      }
      
      private function setState(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
      }
   }
}
