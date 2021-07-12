package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionExtraAwardDesc extends MovieClip implements IDisposable
   {
      
      private static const ICON_WIDTH:uint = 83;
      
      private static const GAP:uint = 10;
       
      
      public var icon:UILoaderAlt = null;
      
      public var lvlTF:TextField;
      
      public var nameTF:TextField;
      
      public function PersonalMissionExtraAwardDesc()
      {
         super();
         this.lvlTF.autoSize = TextFieldAutoSize.RIGHT;
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setDesc(param1:String, param2:String, param3:String) : void
      {
         this.icon.source = param1;
         this.lvlTF.text = param2;
         this.nameTF.text = param3;
         this.layout();
      }
      
      protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.lvlTF = null;
         this.nameTF = null;
      }
      
      private function layout() : void
      {
         var _loc1_:uint = this.lvlTF.textWidth + ICON_WIDTH + this.nameTF.textWidth;
         var _loc2_:int = _loc1_ >> 1;
         this.lvlTF.x = -_loc2_;
         this.icon.x = this.lvlTF.x + this.lvlTF.width - GAP;
         this.nameTF.x = this.icon.x + ICON_WIDTH - GAP;
      }
      
      public function set htmlText(param1:String) : void
      {
         this.lvlTF.htmlText = param1;
      }
   }
}
