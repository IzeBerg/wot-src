package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.fortifications.battleRoom.SortieTeamSection;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieSlotVO;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   
   public class FortClanBattleTeamSection extends SortieTeamSection
   {
       
      
      public function FortClanBattleTeamSection()
      {
         super();
         lblTeamMembers.visible = false;
      }
      
      override protected function getSlotVO(param1:Object) : IRallySlotVO
      {
         return new SortieSlotVO(param1);
      }
      
      override protected function updateTeamHeader() : void
      {
         lblTeamHeader.x = Math.round(this.width - lblTeamHeader.width >> 1);
      }
      
      override public function highlightSlots(param1:Array) : void
      {
         var _loc2_:Vector.<IRallySimpleSlotRenderer> = null;
         var _loc3_:int = 0;
         var _loc4_:SortieSlot = null;
         var _loc5_:int = 0;
         super.highlightSlots(param1);
         if(rallyData && rallyData.isCommander)
         {
            _loc2_ = getSlotsUI();
            _loc3_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = SortieSlot(_loc2_[_loc5_]);
               if(param1.indexOf(_loc5_) != -1)
               {
                  _loc4_.lockFilterOverListener(SortieSlot.ONDRAG_LOCK_FILTER,true);
               }
               _loc5_++;
            }
         }
      }
      
      override public function hideHighLight() : void
      {
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.hideHighLight();
         if(rallyData && rallyData.isCommander)
         {
            _loc1_ = getSlotsUI();
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               SortieSlot(_loc1_[_loc3_]).lockFilterOverListener(SortieSlot.ONDRAG_LOCK_FILTER,false);
               _loc3_++;
            }
         }
      }
      
      public function updateTeamHeaderText(param1:String) : void
      {
         lblTeamHeader.htmlText = param1;
         lblTeamMembers.visible = false;
      }
      
      public function setFiltersData(param1:ButtonFiltersVO) : void
      {
         var _loc2_:SortieSlot = null;
         for each(_loc2_ in getSlotsUI())
         {
            _loc2_.setFiltersData(param1);
         }
      }
   }
}
