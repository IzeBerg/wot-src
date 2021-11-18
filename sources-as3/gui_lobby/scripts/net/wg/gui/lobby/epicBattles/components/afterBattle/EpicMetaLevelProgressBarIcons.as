package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicMetaLevelProgressBarIcons extends MovieClip implements IDisposable
   {
       
      
      public var levelTF:TextField = null;
      
      public function EpicMetaLevelProgressBarIcons()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.levelTF = null;
      }
      
      public function setLevel(param1:int) : void
      {
         this.levelTF.text = param1.toString();
      }
   }
}
