package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CrewSkinSoundInfo extends UIComponentEx
   {
      
      private static const STATE_AVAILABLE:String = "available";
      
      private static const STATE_UNAVAILABLE:String = "unavailable";
       
      
      public var playBtn:ButtonIconNormal;
      
      public var soundName:TextField;
      
      private var _skinID:int;
      
      public function CrewSkinSoundInfo()
      {
         super();
         this.stop();
         this.playBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
         this.playBtn.iconOffsetLeft = 1;
         this.playBtn.iconOffsetTop = -1;
         this.playBtn.addEventListener(MouseEvent.CLICK,this.playHandler);
      }
      
      public function update(param1:int, param2:String, param3:Boolean, param4:Boolean) : void
      {
         this._skinID = param1;
         this.gotoAndStop(!!param4 ? STATE_AVAILABLE : STATE_UNAVAILABLE);
         this.soundName.text = param2;
         this.playBtn.enabled = param3;
      }
      
      override protected function onDispose() : void
      {
         this.playBtn.removeEventListener(MouseEvent.CLICK,this.playHandler);
         this.playBtn.dispose();
         this.playBtn = null;
         this.soundName = null;
         super.onDispose();
      }
      
      private function playHandler(param1:MouseEvent) : void
      {
         var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.PLAY_CREW_SKIN_SOUND,true);
         _loc2_.crewSkinID = this._skinID;
         dispatchEvent(_loc2_);
      }
   }
}
