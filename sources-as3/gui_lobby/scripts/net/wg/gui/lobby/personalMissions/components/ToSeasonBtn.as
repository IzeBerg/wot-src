package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class ToSeasonBtn extends SoundButtonEx
   {
       
      
      public var imageSeason:Sprite = null;
      
      public function ToSeasonBtn()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.imageSeason = null;
         super.onDispose();
      }
   }
}
