package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class RankUpSubElement extends MovieClip implements IDisposable
   {
      
      private static const LINE_PADDING:int = 10;
       
      
      public var mainTF:TextField = null;
      
      public var lineElementMc:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function RankUpSubElement()
      {
         super();
         TextFieldEx.setNoTranslate(this.mainTF,true);
         this.mainTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.mainTF = null;
         this.lineElementMc = null;
      }
      
      public function setText(param1:String) : void
      {
         this.visible = param1 != "";
         this.mainTF.text = param1;
         var _loc2_:int = this.mainTF.textWidth;
         this.mainTF.x = -(_loc2_ >> 1);
         this.lineElementMc.width = _loc2_ + LINE_PADDING;
         this.lineElementMc.x = -(_loc2_ + LINE_PADDING) >> 1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
