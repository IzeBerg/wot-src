package net.wg.gui.bootcamp.messageWindow.views.bottom
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.messageWindow.data.MessageBottomItemVO;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IBottomRenderer;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class BottomButtonsView extends UIComponentEx implements IBottomRenderer
   {
       
      
      public var btnAwardOptions:ISoundButtonEx = null;
      
      public function BottomButtonsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnAwardOptions.addEventListener(ButtonEvent.CLICK,this.onBtnAwardOptionClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.btnAwardOptions.removeEventListener(ButtonEvent.CLICK,this.onBtnAwardOptionClickHandler);
         this.btnAwardOptions.dispose();
         this.btnAwardOptions = null;
         super.onDispose();
      }
      
      public function setData(param1:DataProvider) : void
      {
         var _loc2_:MessageBottomItemVO = null;
         if(param1 && param1.length)
         {
            _loc2_ = param1[0];
            this.btnAwardOptions.label = _loc2_.label;
         }
      }
      
      private function onBtnAwardOptionClickHandler(param1:Event) : void
      {
         this.btnAwardOptions.removeEventListener(ButtonEvent.CLICK,this.onBtnAwardOptionClickHandler);
         dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_OPEN_NATIONS,Values.EMPTY_STR,true));
      }
   }
}
