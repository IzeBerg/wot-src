package net.wg.gui.lobby.training
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.events.ArenaVoipSettingsEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class ArenaVoipSettings extends UIComponentEx
   {
      
      private static const CHANGE_ARENA_VOIP:String = "changeArenaVOIP";
      
      private static const USE_ARENA_VOIP:String = "useArenaVOIP";
       
      
      private var canChangeArenaVOIP:Boolean = false;
      
      private var useArenaVoip:Number = 0;
      
      public var voiceChatDD:DropdownMenu;
      
      public var textField:TextFieldShort;
      
      public function ArenaVoipSettings()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.buttonMode = false;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.voiceChatDD.dataProvider = new DataProvider([MENU.TRAINING_INFO_USECOMMONVOICECHAT,MENU.TRAINING_INFO_USESEPARATEVOIPCHAT]);
         this.voiceChatDD.selectedIndex = 0;
         this.voiceChatDD.addEventListener(ListEvent.INDEX_CHANGE,this.handleChange,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.stopCoolDownUseCommonVoiceChat);
         this.voiceChatDD.removeEventListener(ListEvent.INDEX_CHANGE,this.handleChange,false);
         this.voiceChatDD.dispose();
         this.voiceChatDD = null;
         this.textField.dispose();
         this.textField = null;
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         this.voiceChatDD.enabled = param1;
         this.textField.enabled = param1;
      }
      
      public function setCanChangeArenaVOIP(param1:Boolean) : void
      {
         if(this.canChangeArenaVOIP == param1)
         {
            return;
         }
         this.canChangeArenaVOIP = param1;
         invalidate(ArenaVoipSettings.CHANGE_ARENA_VOIP);
      }
      
      public function setUseArenaVoip(param1:Number) : void
      {
         this.useArenaVoip = param1;
         invalidate(ArenaVoipSettings.USE_ARENA_VOIP);
      }
      
      private function handleChange(param1:ListEvent) : void
      {
         if(this.canChangeArenaVOIP)
         {
            dispatchEvent(new ArenaVoipSettingsEvent(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.voiceChatDD.selectedIndex));
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ArenaVoipSettings.CHANGE_ARENA_VOIP))
         {
            this.voiceChatDD.visible = this.canChangeArenaVOIP;
            this.textField.visible = !this.canChangeArenaVOIP;
         }
         if(isInvalid(ArenaVoipSettings.USE_ARENA_VOIP))
         {
            if(this.canChangeArenaVOIP)
            {
               this.voiceChatDD.selectedIndex = this.useArenaVoip;
            }
            else
            {
               if(this.useArenaVoip == -1)
               {
                  this.textField.label = MENU.TRAINING_INFO_NOTUSECHAT;
               }
               else if(this.useArenaVoip == 0)
               {
                  this.textField.label = MENU.TRAINING_INFO_USECOMMONVOICECHAT;
               }
               else
               {
                  this.textField.label = MENU.TRAINING_INFO_USESEPARATEVOIPCHAT;
               }
               this.textField.validateNow();
            }
         }
      }
      
      public function startCoolDownUseCommonVoiceChat(param1:Number) : void
      {
         this.voiceChatDD.enabled = false;
         var _loc2_:IScheduler = App.utils.scheduler;
         _loc2_.cancelTask(this.stopCoolDownUseCommonVoiceChat);
         _loc2_.scheduleTask(this.stopCoolDownUseCommonVoiceChat,param1 * 1000);
      }
      
      private function stopCoolDownUseCommonVoiceChat() : void
      {
         this.voiceChatDD.enabled = true;
      }
      
      public function changeUseArenaVoipFailed(param1:Number) : void
      {
         App.utils.scheduler.cancelTask(this.stopCoolDownUseCommonVoiceChat);
         if(this.canChangeArenaVOIP)
         {
            this.voiceChatDD.enabled = true;
            this.voiceChatDD.selectedIndex = param1;
         }
      }
   }
}
