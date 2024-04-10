package net.wg.gui.battle.pveBase.views.progressCounter
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TitleAnimation extends MovieClip implements IDisposable
   {
      
      private static const ICON_OFFSET:int = 9;
      
      private static const ICON_WIDTH:int = 18;
       
      
      public var icon:BattleAtlasSprite = null;
      
      public var textTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TitleAnimation()
      {
         super();
      }
      
      public function setIcon(param1:String) : void
      {
         if(param1.length != 0)
         {
            this.icon.imageName = param1;
         }
      }
      
      public function setText(param1:String) : void
      {
         this.textTF.text = param1;
         this.icon.x = this.textTF.x + this.textTF.width - this.textTF.textWidth - ICON_OFFSET - ICON_WIDTH;
      }
      
      public function setVisibleIcon(param1:Boolean) : void
      {
         this.icon.visible = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon = null;
         this.textTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
