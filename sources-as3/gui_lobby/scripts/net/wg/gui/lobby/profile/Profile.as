package net.wg.gui.lobby.profile
{
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.infrastructure.base.meta.IProfileMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class Profile extends ProfileMeta implements IProfileMeta
   {
       
      
      public var tabNavigator:ProfileTabNavigator;
      
      public var screenBg:ScreenBg = null;
      
      public var glow:Sprite = null;
      
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
         this.screenBg.setSize(_width,_height);
      }
      
      public function as_update(param1:Object) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setViewSize(param1,param2);
         this.screenBg.setSize(_width,_height);
         this.screenBg.headerBg.x = 0;
         this.screenBg.headerBg.width = App.appWidth;
         this.glow.width = _width;
         this.glow.height = _height;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.tabNavigator.setAvailableSize(_width,_height - this.tabNavigator.y);
            this.screenBg.setSize(_width,_height);
         }
      }
      
      override protected function onDispose() : void
      {
         this.screenBg.dispose();
         this.screenBg = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         super.onDispose();
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
   }
}
