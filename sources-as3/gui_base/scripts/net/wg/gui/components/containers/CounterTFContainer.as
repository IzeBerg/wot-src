package net.wg.gui.components.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.ILabel;
   import net.wg.infrastructure.interfaces.IMovieLabel;
   
   public class CounterTFContainer extends MovieClip implements IMovieLabel
   {
       
      
      public var textFieldMc:ILabel;
      
      public function CounterTFContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.textFieldMc.dispose();
         this.textFieldMc = null;
      }
      
      public function get text() : String
      {
         return this.textFieldMc.text;
      }
      
      public function set text(param1:String) : void
      {
         this.textFieldMc.text = param1;
      }
   }
}
