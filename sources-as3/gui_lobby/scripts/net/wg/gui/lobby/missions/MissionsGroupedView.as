package net.wg.gui.lobby.missions
{
   import net.wg.gui.lobby.eventBoards.events.MissionPremiumEvent;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import net.wg.infrastructure.base.meta.IMissionsGroupedViewMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsGroupedViewMeta;
   
   public class MissionsGroupedView extends MissionsGroupedViewMeta implements IMissionsGroupedViewMeta
   {
       
      
      public function MissionsGroupedView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MissionHeaderEvent.COLLAPSE,this.onCollapseHandler);
         addEventListener(MissionHeaderEvent.MOVE_TO_ACTION,this.onMoveToActionHandler);
         addEventListener(TypeEvent.LINKED_SET_USE_TOKEN,this.onUseTokenClickHandler);
         addEventListener(MissionPremiumEvent.BUTTON_DETAILS_CLICK,this.onButtonDetailsClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(TypeEvent.LINKED_SET_USE_TOKEN,this.onUseTokenClickHandler);
         removeEventListener(MissionHeaderEvent.MOVE_TO_ACTION,this.onMoveToActionHandler);
         removeEventListener(MissionHeaderEvent.COLLAPSE,this.onCollapseHandler);
         removeEventListener(MissionPremiumEvent.BUTTON_DETAILS_CLICK,this.onButtonDetailsClickHandler);
         super.onDispose();
      }
      
      private function onMoveToActionHandler(param1:MissionHeaderEvent) : void
      {
         clickActionBtnS(param1.actionId);
      }
      
      private function onCollapseHandler(param1:MissionHeaderEvent) : void
      {
         expandS(param1.missionId,!param1.isCollapsed);
      }
      
      private function onUseTokenClickHandler(param1:TypeEvent) : void
      {
         useTokenClickS(param1.id);
      }
      
      private function onButtonDetailsClickHandler(param1:MissionPremiumEvent) : void
      {
         onClickButtonDetailsS();
      }
   }
}
