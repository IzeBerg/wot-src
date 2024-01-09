package net.wg.gui.components.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.ILabel;
   import net.wg.infrastructure.interfaces.IMovieLabel;
   
   public class CounterTFContainer extends MovieClip implements IMovieLabel
   {
       
      
      public var textFieldMc:ILabel;
      
      private var _disposed:Boolean = false;
      
      public function CounterTFContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
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
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setTextAutoSize(param1:String) : void
      {
         this.textFieldMc.setTextAutoSize(param1);
      }
   }
}
