package net.wg.gui.lobby.profile
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.infrastructure.base.meta.IProfileMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class Profile extends ProfileMeta implements IProfileMeta
   {
       
      
      public var screenBg:ScreenBg = null;
      
      public var tabNavigator:ProfileTabNavigator;
      
      public function Profile()
      {
         super();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         onCloseProfileS();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         registerFlashComponentS(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
         this.tabNavigator.centerOffset = ProfileConstants.MAIN_CENTER_OFFSET;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }
      
      public function as_update(param1:Object) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setViewSize(param1,param2);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.screenBg.setSize(_width,_height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT);
            this.tabNavigator.setAvailableSize(_width,_height - this.tabNavigator.y);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.screenBg)
         {
            this.screenBg.parent.removeChild(this.screenBg);
            this.screenBg.dispose();
            this.screenBg = null;
         }
         this.tabNavigator = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         super.onDispose();
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
   }
}
