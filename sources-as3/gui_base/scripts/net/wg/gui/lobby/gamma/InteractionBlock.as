package net.wg.gui.lobby.gamma
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InteractionBlock extends Sprite implements IDisposable
   {
       
      
      public var header:TextField = null;
      
      public var applyButton:ISoundButtonEx = null;
      
      public var cancelButton:ISoundButtonEx = null;
      
      public var defaultButton:ISoundButtonEx = null;
      
      public var slider:Slider = null;
      
      private var _disposed:Boolean = false;
      
      public function InteractionBlock()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.header = null;
         this.applyButton.dispose();
         this.applyButton = null;
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.defaultButton.dispose();
         this.defaultButton = null;
         this.slider.dispose();
         this.slider = null;
      }
      
      public function initData(param1:GammaInitVO) : void
      {
         this.header.htmlText = param1.header;
         this.applyButton.label = param1.applyLabel;
         this.cancelButton.label = param1.cancelLabel;
         this.defaultButton.label = param1.defaultLabel;
         this.slider.minimum = param1.minValue;
         this.slider.maximum = param1.maxValue;
         this.slider.value = param1.currentValue;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
