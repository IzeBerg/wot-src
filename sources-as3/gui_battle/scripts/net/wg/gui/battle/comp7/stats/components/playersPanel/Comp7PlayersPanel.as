package net.wg.gui.battle.comp7.stats.components.playersPanel
{
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.events.VoiceChatActivationEvent;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelList;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListLeft;
   import net.wg.infrastructure.base.meta.IComp7PlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7PlayersPanelMeta;
   
   public class Comp7PlayersPanel extends Comp7PlayersPanelMeta implements IComp7PlayersPanelMeta, IPoiContainer
   {
       
      
      public function Comp7PlayersPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
         super.onDispose();
      }
      
      override protected function setVoiceChatData(param1:VoiceChatActivationVO) : void
      {
         IComp7PlayersPanelListLeft(listLeft).setVoiceChatData(param1);
      }
      
      public function as_setVoiceChatControlSelected(param1:Boolean) : void
      {
         IComp7PlayersPanelListLeft(listLeft).setVoiceChatControlActive(param1);
      }
      
      public function as_setVoiceChatControlVisible(param1:Boolean) : void
      {
         IComp7PlayersPanelListLeft(listLeft).setVoiceChatVisibility(param1);
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         IComp7PlayersPanelList(listLeft).removePointOfInterest(param1,param2);
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         IComp7PlayersPanelList(listLeft).updatePointOfInterest(param1);
      }
      
      private function onVoiceChatControlClickedHandler(param1:VoiceChatActivationEvent) : void
      {
         onVoiceChatControlClickS();
      }
   }
}
