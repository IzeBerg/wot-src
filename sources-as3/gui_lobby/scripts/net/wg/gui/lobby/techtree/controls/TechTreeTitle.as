package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TechTreeTitle extends MovieClip implements IDisposable
   {
      
      private static const _BIG_TITLE_STATE:String = "big";
      
      private static const _SMALL_TITLE_STATE:String = "small";
      
      private static const _ALREADY_DISPOSED_MESSAGE:String = "(TechTreeTitle) already disposed!";
      
      private static const _HEIGHT_SMALL:int = 36;
      
      private static const _HEIGHT_BIG:int = 58;
      
      private static const _Y_SMALL:int = 36;
      
      private static const _Y_BIG:int = 33;
      
      private static const _HEIGHT_BREAKPOINT:int = 837;
       
      
      public var titleTF:TextField = null;
      
      protected var _baseDisposed:Boolean = false;
      
      private var _titleStr:String = "";
      
      public function TechTreeTitle()
      {
         super();
      }
      
      public final function dispose() : void
      {
         App.utils.asserter.assert(!this._baseDisposed,name + _ALREADY_DISPOSED_MESSAGE);
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function updateSize(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param2 >= _HEIGHT_BREAKPOINT;
         this.y = !!_loc3_ ? Number(_Y_BIG) : Number(_Y_SMALL);
         this.gotoAndStop(!!_loc3_ ? _BIG_TITLE_STATE : _SMALL_TITLE_STATE);
         if(this._baseDisposed)
         {
            return;
         }
         this.titleTF.text = this._titleStr;
         this.titleTF.width = param1;
         this.titleTF.height = !!_loc3_ ? Number(_HEIGHT_BIG) : Number(_HEIGHT_SMALL);
         TextFieldEx.setVerticalAlign(this.titleTF,TextFieldEx.VALIGN_CENTER);
      }
      
      protected function onDispose() : void
      {
         this.titleTF = null;
      }
      
      public function set updateTitle(param1:String) : void
      {
         this._titleStr = param1;
         this.titleTF.text = param1;
      }
      
      public function get titleWidth() : Number
      {
         return this.titleTF.textWidth;
      }
   }
}
