package net.wg.gui.components.crosshairPanel.components.speedometer
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SpeedometerWarningAnim extends MovieClip implements IDisposable
   {
      
      private static const TEXTFIELD_PADDING:uint = 5;
       
      
      public var warning:MovieClip;
      
      private var _warningText:TextField;
      
      public function SpeedometerWarningAnim()
      {
         super();
         this._warningText = this.warning.warningText;
      }
      
      public final function dispose() : void
      {
         this.warning = null;
         this._warningText = null;
      }
      
      public function setText(param1:String) : void
      {
         var _loc2_:int = this._warningText.x + this._warningText.width;
         this._warningText.text = param1;
         this._warningText.width = this._warningText.textWidth + TEXTFIELD_PADDING;
         this._warningText.x = _loc2_ - this._warningText.width | 0;
      }
   }
}
