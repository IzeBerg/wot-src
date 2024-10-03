package net.wg.white_tiger.gui.battle.views.wtHunterRespawn
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class WTHunterRespawnHint extends Sprite implements IDisposable
   {
      
      private static const TITLE_WIDTH_BIG:int = 525;
      
      private static const TITLE_WIDTH_SMALL:int = 300;
      
      private static const TITLE_FONT_SIZE_BIG:int = 26;
      
      private static const TITLE_FONT_SIZE_SMALL:int = 16;
       
      
      public var hintAnimation:MovieClip = null;
      
      public var hintTF:TextField = null;
      
      public var hintBg:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      private var _isSmall:Boolean = false;
      
      private var _titleTextFormatBig:TextFormat;
      
      private var _titleTextFormatSmall:TextFormat;
      
      public function WTHunterRespawnHint()
      {
         this._titleTextFormatBig = new TextFormat();
         this._titleTextFormatSmall = new TextFormat();
         super();
         this._titleTextFormatBig.size = TITLE_FONT_SIZE_BIG;
         this._titleTextFormatSmall.size = TITLE_FONT_SIZE_SMALL;
         this.hintTF.autoSize = TextFieldAutoSize.LEFT;
         this.hintTF.text = EVENT.HUNTERRESPAWN_HINTTEXT;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.hintAnimation = null;
         this.hintTF = null;
         this.hintBg = null;
         this._titleTextFormatBig = null;
         this._titleTextFormatSmall = null;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            this.hintTF.width = !!this._isSmall ? Number(TITLE_WIDTH_SMALL) : Number(TITLE_WIDTH_BIG);
            this.hintTF.setTextFormat(!!this._isSmall ? this._titleTextFormatSmall : this._titleTextFormatBig);
            this.hintTF.y = this.hintAnimation.height - this.hintTF.textHeight >> 1;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
