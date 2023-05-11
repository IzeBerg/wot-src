package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class MetaLevelTextWrapper extends UIComponentEx
   {
       
      
      public var tf:TextField;
      
      public var overlay:MetaLevelTextWrapperOverlay;
      
      private var _textSize:int = 0;
      
      private var _text:String = null;
      
      private var _commons:ICommons;
      
      public function MetaLevelTextWrapper()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      private static function updateTextSize(param1:TextField, param2:int) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.size = param2;
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc3_;
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         super.gotoAndStop(param1,param2);
         this.overlay.gotoAndStop(param1,param2);
         this._text = null;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._textSize > 0 && this._text != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.overlay.dispose();
         this.overlay = null;
         this.tf = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            invalidateData();
         }
      }
      
      public function setTextSize(param1:int) : void
      {
         if(this._textSize != param1)
         {
            this._textSize = param1;
            invalidateData();
         }
      }
      
      protected function updateData() : void
      {
         this.tf.text = this._text;
         this.overlay.tf.text = this._text;
         updateTextSize(this.tf,this._textSize);
         updateTextSize(this.overlay.tf,this._textSize);
         this._commons.updateTextFieldSize(this.tf,true,true);
         this._commons.updateTextFieldSize(this.overlay.tf,true,true);
         this.overlay.updateSize();
         width = this.tf.width;
         height = this.tf.height;
      }
   }
}
