package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationImageVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationHintImageWrapper extends UIComponentEx implements IUpdatable
   {
      
      private static const IMAGINARY_WIDTH:int = 38;
       
      
      public var tf:TextField = null;
      
      public var border:MovieClip = null;
      
      public var image:Image = null;
      
      private var _data:CustomizationImageVO;
      
      private var _originTextWidth:int = 0;
      
      private var _originBorderWidth:int = 0;
      
      private var _ratio:Number = 1;
      
      private var _ratioDiff:Number = 0;
      
      public function CustomizationHintImageWrapper()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._originTextWidth = this.tf.width;
         this._originBorderWidth = this.border.width;
         this._ratioDiff = IMAGINARY_WIDTH / this._originBorderWidth;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.tf = null;
         this.border = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.image.source = this._data.image;
            _loc1_ = this._data.text;
            this.tf.text = _loc1_;
            this.border.visible = StringUtils.isNotEmpty(_loc1_);
            if(this.border.visible)
            {
               App.utils.commons.updateTextFieldSize(this.tf,true,false);
               this._ratio = this.tf.width / this._originTextWidth - this._ratioDiff;
               if(this._ratio > 1)
               {
                  this.border.width = this._originBorderWidth * this._ratio ^ 0;
               }
               this.tf.x = this.border.width - this.tf.width >> 1;
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = CustomizationImageVO(param1);
         invalidateData();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.RESIZE,true));
      }
   }
}
