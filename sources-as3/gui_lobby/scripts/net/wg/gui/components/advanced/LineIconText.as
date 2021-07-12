package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class LineIconText extends UIComponentEx
   {
      
      public static const TEXT_INVALID:String = "txtInv";
      
      public static const ICON_INVALID:String = "iconInv";
       
      
      public var textComponent:UnderlinedText;
      
      public var icon:UILoaderAlt;
      
      protected var _text:String = "";
      
      private var _iconSource:String;
      
      public function LineIconText()
      {
         super();
      }
      
      [Inspectable(type="String")]
      public function set text(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            invalidate(TEXT_INVALID);
         }
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(TEXT_INVALID))
         {
            this.applyText(this._text);
         }
         if(isInvalid(ICON_INVALID) && this.icon)
         {
            this.icon.source = this._iconSource;
         }
      }
      
      protected function applyText(param1:String) : void
      {
         this.textComponent.text = param1;
      }
      
      [Inspectable(type="String")]
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            invalidate(ICON_INVALID);
         }
      }
      
      override protected function onDispose() : void
      {
         this.textComponent = null;
         super.onDispose();
         if(this.icon)
         {
            this.icon.dispose();
         }
         this.icon = null;
      }
   }
}
