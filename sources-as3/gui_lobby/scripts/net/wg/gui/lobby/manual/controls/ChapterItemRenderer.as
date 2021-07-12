package net.wg.gui.lobby.manual.controls
{
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class ChapterItemRenderer extends SoundButtonEx
   {
      
      private static const FONT_SMALL:int = 21;
      
      private static const FONT_NORMAL:int = 30;
       
      
      public var loader:UILoaderAlt;
      
      public function ChapterItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.mouseChildren = false;
         this.loader.mouseEnabled = false;
         TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_CENTER);
         displayFocus = false;
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = textField.getTextFormat();
            _loc1_.size = scaleX < 1 ? FONT_SMALL : FONT_NORMAL;
            textField.setTextFormat(_loc1_);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         var _loc2_:ChapterItemRendererVO = ChapterItemRendererVO(data);
         this.loader.source = _loc2_.image;
         label = _loc2_.label;
         tooltip = _loc2_.tooltip;
      }
   }
}
