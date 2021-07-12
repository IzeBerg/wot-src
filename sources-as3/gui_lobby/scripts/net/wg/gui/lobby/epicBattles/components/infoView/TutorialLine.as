package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialLine extends Sprite implements IDisposable
   {
       
      
      public var lineTF:TextField = null;
      
      public function TutorialLine()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.lineTF = null;
      }
   }
}
