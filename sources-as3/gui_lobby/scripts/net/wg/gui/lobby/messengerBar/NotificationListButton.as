package net.wg.gui.lobby.messengerBar
{
   import flash.display.DisplayObject;
   import flash.text.TextFormatAlign;
   import net.wg.data.Aliases;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.advanced.BlinkingButton;
   import net.wg.gui.lobby.messengerBar.interfaces.INotificationListButton;
   import net.wg.infrastructure.base.meta.impl.NotificationListButtonMeta;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class NotificationListButton extends NotificationListButtonMeta implements INotificationListButton
   {
      
      private static const COUNTER_PROPS:ICounterProps = new CounterProps(10,-3,TextFormatAlign.RIGHT);
       
      
      public var button:BlinkingButton;
      
      private var _counterManager:ICounterManager = null;
      
      public function NotificationListButton()
      {
         super();
         this._counterManager = App.utils.counterManager;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onClickHandler,false,0,true);
         this.button.tooltip = TOOLTIPS.LOBY_MESSENGER_SERVICE_BUTTON;
         this.button.soundType = SoundTypes.MESSANGER_BTN;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.button.dispose();
         this.button = null;
         this._counterManager.removeCounter(this);
         this._counterManager = null;
         super.onDispose();
      }
      
      public function as_setState(param1:Boolean, param2:String) : void
      {
         if(this.button.blinking != param1)
         {
            this.button.blinking = param1;
         }
         if(StringUtils.isNotEmpty(param2))
         {
            this._counterManager.setCounter(this,param2,null,COUNTER_PROPS);
         }
         else
         {
            this._counterManager.removeCounter(this);
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.button;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.button;
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         handleClickS();
         App.popoverMgr.show(this,Aliases.NOTIFICATIONS_LIST);
      }
   }
}
