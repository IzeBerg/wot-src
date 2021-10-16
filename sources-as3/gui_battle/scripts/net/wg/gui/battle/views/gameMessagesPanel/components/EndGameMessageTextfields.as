package net.wg.gui.battle.views.gameMessagesPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EndGameMessageTextfields extends MovieClip implements IDisposable
   {
       
      
      public var titleTF:TextField = null;
      
      public var subtitleTF:TextField = null;
      
      public function EndGameMessageTextfields()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.titleTF = null;
         this.subtitleTF = null;
      }
   }
}
