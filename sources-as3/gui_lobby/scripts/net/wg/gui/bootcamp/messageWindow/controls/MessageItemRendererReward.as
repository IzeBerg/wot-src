package net.wg.gui.bootcamp.messageWindow.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   
   public class MessageItemRendererReward extends MessageItemRendererBase
   {
       
      
      public var iconLoader:UILoaderAlt;
      
      public function MessageItemRendererReward()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.iconLoader.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.iconLoader.source = data.icon;
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.iconLoader.dispose();
         this.iconLoader = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         super.onDispose();
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         if(data.animationTarget)
         {
            this.iconLoader.dispatchEvent(new MessageViewEvent(MessageViewEvent.REWARD_ICON_LOADED,true));
         }
      }
      
      private function onMouseOverHandler(param1:Event) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BOOTCAMP_AWARD_MEDAL,null,data.labelTooltip,data.description,data.iconTooltip);
      }
      
      private function onMouseOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
