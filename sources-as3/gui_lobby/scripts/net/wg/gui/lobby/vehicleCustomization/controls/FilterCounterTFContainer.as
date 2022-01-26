package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.common.CounterLabel;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FilterCounterTFContainer extends MovieClip implements IDisposable
   {
       
      
      public var textFieldMc:CounterLabel;
      
      public function FilterCounterTFContainer()
      {
         super();
      }
      
      public final function dispose() : void
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
      
      public function get htmlText() : String
      {
         return this.textFieldMc.text;
      }
      
      public function set htmlText(param1:String) : void
      {
         this.textFieldMc.text = param1;
      }
   }
}
