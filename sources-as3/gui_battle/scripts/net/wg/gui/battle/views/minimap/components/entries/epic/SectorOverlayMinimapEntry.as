package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   
   public class SectorOverlayMinimapEntry extends BattleUIComponent
   {
       
      
      public function SectorOverlayMinimapEntry()
      {
         super();
      }
      
      public function changeSectorState(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = Values.EMPTY_STR;
         if(param1 == EPIC_CONSTS.SECTOR_CAPTURED)
         {
            _loc4_ = !param2 ? EpicMinimapEntryConst.SUFIX_ENEMY : EpicMinimapEntryConst.SUFIX_ALLY;
            if(param3)
            {
               _loc4_ += EpicMinimapEntryConst.SECTOR_HQ_POSTFIX_ATLAS_ITEM_NAME;
            }
            gotoAndStop(_loc4_);
         }
         else
         {
            gotoAndStop(EpicMinimapEntryConst.EMPTY);
         }
      }
   }
}
