package net.wg.gui.lobby.progressiveReward
{
   import flash.events.Event;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
   import net.wg.infrastructure.base.meta.IProgressiveRewardWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.ProgressiveRewardWidgetMeta;
   
   public class ProgressiveRewardWidget extends ProgressiveRewardWidgetMeta implements IProgressiveRewardWidgetMeta
   {
       
      
      public var progressiveReward:ProgressiveReward = null;
      
      public function ProgressiveRewardWidget()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.progressiveReward.removeEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
         this.progressiveReward.removeEventListener(ProgressiveRewardEvent.OPEN_BTN_CLICK,this.onProgressiveRewardOpenBtnClickHandler);
         this.progressiveReward.dispose();
         this.progressiveReward = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressiveReward.addEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
         this.progressiveReward.addEventListener(ProgressiveRewardEvent.OPEN_BTN_CLICK,this.onProgressiveRewardOpenBtnClickHandler);
      }
      
      override protected function setData(param1:ProgressiveRewardVO) : void
      {
         this.progressiveReward.setData(param1);
      }
      
      private function onProgressiveRewardOpenBtnClickHandler(param1:Event) : void
      {
         onOpenBtnClickS();
      }
      
      private function onProgressiveRewardLinkBtnClickHandler(param1:ProgressiveRewardEvent) : void
      {
         onWidgetClickS();
      }
   }
}
