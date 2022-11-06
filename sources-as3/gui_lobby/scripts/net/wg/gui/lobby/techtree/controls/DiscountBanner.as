package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class DiscountBanner extends MovieClip implements IDisposable
   {
      
      private static const BUY_BG_FRAME:String = "red";
      
      private static const UNLOCK_BG_FRAME:String = "blue";
      
      private static const ALREADY_DISPOSED_MESSAGE:String = "(DiscountBanner) already disposed!";
       
      
      public var discountTF:TextField = null;
      
      protected var _baseDisposed:Boolean = false;
      
      public function DiscountBanner()
      {
         super();
         TextFieldEx.setVerticalAlign(this.discountTF,TextFieldEx.VALIGN_CENTER);
      }
      
      public final function dispose() : void
      {
         App.utils.asserter.assert(!this._baseDisposed,name + ALREADY_DISPOSED_MESSAGE);
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function setData(param1:String, param2:Boolean = true) : void
      {
         gotoAndStop(!!param2 ? UNLOCK_BG_FRAME : BUY_BG_FRAME);
         if(this._baseDisposed)
         {
            return;
         }
         this.discountTF.htmlText = param1;
      }
      
      protected function onDispose() : void
      {
         this.discountTF = null;
      }
   }
}
