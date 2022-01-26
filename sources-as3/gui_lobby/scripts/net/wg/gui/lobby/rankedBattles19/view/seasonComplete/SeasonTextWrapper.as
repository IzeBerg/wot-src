package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SeasonTextWrapper extends MovieClip implements IDisposable
   {
       
      
      public var tf:TextField = null;
      
      public function SeasonTextWrapper()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.tf = null;
      }
      
      public function setText(param1:String) : void
      {
         this.tf.text = param1;
      }
      
      public function setHtmlText(param1:String) : void
      {
         this.tf.htmlText = param1;
      }
   }
}
